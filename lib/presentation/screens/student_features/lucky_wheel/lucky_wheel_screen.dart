import 'dart:async';
import 'dart:math' as math;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/student_features/lucky_prize_model.dart';
import 'package:swallet_mobile/data/repositories/student_features/lucky_prize_repository.dart';
import 'package:swallet_mobile/data/repositories/student_features/wheel_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/wheel_repository.dart';
import 'package:swallet_mobile/presentation/blocs/lucky/lucky_wheel_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/lucky/lucky_wheel_event.dart';
import 'package:swallet_mobile/presentation/blocs/lucky/lucky_wheel_state.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class LuckyWheelScreen extends StatelessWidget {
  const LuckyWheelScreen({super.key});
  static const String routeName = '/lucky-wheel';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LuckyWheelScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              LuckyWheelBloc(repository: context.read<LuckyPrizeRepository>())
                ..add(LoadPrizes()),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<SpinHistoryRepository>(
            create: (context) => SpinHistoryRepositoryImpl(),
          ),
        ],
        child: const LuckyWheelView(),
      ),
    );
  }
}

class LuckyWheelView extends StatefulWidget {
  const LuckyWheelView({super.key});

  @override
  State<LuckyWheelView> createState() => _LuckyWheelViewState();
}

class _LuckyWheelViewState extends State<LuckyWheelView>
    with SingleTickerProviderStateMixin {
  final StreamController<int> _controller = StreamController<int>();
  String _selectedPrize = '';
  bool _isSpinning = false;
  LuckyPrize? _selectedLuckyPrize;

  late AnimationController _lightAnimationController;
  late Animation<double> _lightAnimation;

  @override
  void initState() {
    super.initState();

    _lightAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _lightAnimation = Tween<double>(begin: 8, end: 20).animate(
      CurvedAnimation(
        parent: _lightAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    _lightAnimationController.dispose();
    super.dispose();
  }

  Future<void> _spinWheel(List<LuckyPrize> prizes) async {
    // Nếu đang quay thì không cho phép thực hiện tiếp
    if (_isSpinning) return;

    final student = await AuthenLocalDataSource.getStudent();
    final studentId = student?.id;

    if (studentId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Không tìm thấy studentId')));
      return;
    }

    final today = DateTime.now();
    final spinCount = await context.read<SpinHistoryRepository>().getSpinCount(
      studentId,
      today,
    );
    final bonusSpins = await context
        .read<SpinHistoryRepository>()
        .getBonusSpins(studentId, today);
    final maxSpins = 3 + bonusSpins;

    // Kiểm tra số lượt quay còn lại trước khi quay
    if (spinCount >= maxSpins) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            elevation: 0,
            duration: const Duration(milliseconds: 2000),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Hết lượt quay!',
              message:
                  'Bạn đã hết lượt quay hôm nay. Hãy quay lại vào ngày mai!',
              contentType: ContentType.warning,
            ),
          ),
        );
      return;
    }

    // Đặt trạng thái đang quay và cập nhật giao diện
    setState(() {
      _isSpinning = true;
      _selectedPrize = '';
      _selectedLuckyPrize = null;
    });

    final randomIndex = _selectPrizeIndex(prizes);
    _controller.add(randomIndex);

    // Chờ animation hoàn tất (4 giây)
    await Future.delayed(const Duration(seconds: 4));

    // Xử lý kết quả sau khi quay xong
    final selectedPrize = prizes[randomIndex];
    await context.read<SpinHistoryRepository>().incrementSpinCount(
      studentId,
      today,
    );

    if (selectedPrize.quantity > 0) {
      await context.read<LuckyPrizeRepository>().updatePrizeQuantity(
        selectedPrize.id,
        selectedPrize.quantity - 1,
      );
    }

    if (selectedPrize.value > 0) {
      try {
        await context.read<StudentRepository>().updateWalletByStudentId(
          studentId,
          selectedPrize.value,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              elevation: 0,
              duration: const Duration(milliseconds: 2000),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Xin chúc mừng!',
                message: 'Đã cộng ${selectedPrize.value} Xu vào ví của bạn!',
                contentType: ContentType.success,
              ),
            ),
          );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
      }
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            elevation: 0,
            duration: const Duration(milliseconds: 2000),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Chúc bạn may mắn lần sau!',
              message:
                  'Lần này không trúng rồi, nhưng bạn có thể quay lại sau!',
              contentType: ContentType.success,
            ),
          ),
        );
    }

    // Cập nhật trạng thái sau khi quay xong
    setState(() {
      _selectedPrize = selectedPrize.prizeName;
      _selectedLuckyPrize = selectedPrize;
      _isSpinning = false;
    });
  }

  int _selectPrizeIndex(List<LuckyPrize> prizes) {
    final totalProbability = prizes.fold<double>(
      0,
      (sum, prize) => sum + prize.probability,
    );
    final randomValue =
        (DateTime.now().millisecondsSinceEpoch % 1000) /
        1000 *
        totalProbability;

    // Duyệt qua từng phần thưởng trong danh sách prizes:
    // Cộng probability của phần thưởng hiện tại vào cumulativeProbability.
    // Nếu randomValue nhỏ hơn hoặc bằng cumulativeProbability, trả về chỉ số i của phần thưởng đó.
    // Nếu không phần thưởng nào được chọn (do lỗi làm tròn hoặc trường hợp đặc biệt), trả về chỉ số của phần thưởng cuối cùng (prizes.length - 1).

    double cumulativeProbability = 0;
    for (int i = 0; i < prizes.length; i++) {
      cumulativeProbability += prizes[i].probability;
      if (randomValue <= cumulativeProbability) {
        return i;
      }
    }
    return prizes.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Vòng Quay May Mắn',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 22 * ffem,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kPrimaryColor, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BlocBuilder<LuckyWheelBloc, LuckyWheelState>(
          builder: (context, state) {
            if (state is LuckyWheelLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LuckyWheelLoaded) {
              final prizes = state.prizes;
              if (prizes.isEmpty) {
                return const Center(child: Text('Không có phần thưởng nào'));
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 0 * hem),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 340 * fem,
                          height: 340 * fem,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 300 * fem,
                          height: 300 * fem,
                          child: FortuneWheel(
                            selected: _controller.stream,
                            items:
                                prizes
                                    .asMap()
                                    .entries
                                    .map(
                                      (entry) => FortuneItem(
                                        child: Text(
                                          entry.value.prizeName,
                                          style: GoogleFonts.openSans(
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        style: FortuneItemStyle(
                                          color:
                                              entry.key % 2 == 0
                                                  ? Colors.yellow
                                                  : Colors.redAccent,
                                          borderColor: Colors.black,
                                          borderWidth: 2,
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onAnimationEnd: () {
                              // Đã được xử lý trong _spinWheel
                            },
                          ),
                        ),
                        ...List.generate(20, (index) {
                          final angle = 2 * math.pi * index / 20;
                          final radius = 158 * fem;
                          return Positioned(
                            left:
                                radius * math.cos(angle) + 170 * fem - 12 * fem,
                            top:
                                radius * math.sin(angle) + 170 * fem - 12 * fem,
                            child: AnimatedBuilder(
                              animation: _lightAnimation,
                              builder: (context, child) {
                                return Container(
                                  width: 23 * fem,
                                  height: 23 * fem,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.yellow,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.yellow.withOpacity(0.9),
                                        blurRadius: _lightAnimation.value,
                                        spreadRadius: _lightAnimation.value / 2,
                                      ),
                                    ],
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2 * fem,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 40 * hem),
                    FutureBuilder<int>(
                      future: () async {
                        final student =
                            await AuthenLocalDataSource.getStudent();
                        final studentId = student?.id;
                        if (studentId == null) return 0;
                        final spinCount = await context
                            .read<SpinHistoryRepository>()
                            .getSpinCount(studentId, DateTime.now());
                        final bonusSpins = await context
                            .read<SpinHistoryRepository>()
                            .getBonusSpins(studentId, DateTime.now());
                        final maxSpins = 3 + bonusSpins;
                        return maxSpins - spinCount;
                      }(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            'Lỗi: ${snapshot.error}',
                            style: GoogleFonts.openSans(
                              fontSize: 16 * ffem,
                              color: Colors.red,
                            ),
                          );
                        } else {
                          final remainingSpins = snapshot.data ?? 0;
                          return Text(
                            'Bạn còn $remainingSpins lượt quay hôm nay',
                            style: GoogleFonts.openSans(
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 40 * hem),
                    ElevatedButton(
                      onPressed: _isSpinning ? null : () => _spinWheel(prizes),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40 * fem,
                          vertical: 15 * hem,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30 * fem),
                        ),
                      ),
                      child: Text(
                        _isSpinning ? 'Đang quay...' : 'QUAY',
                        style: GoogleFonts.openSans(
                          fontSize: 18 * ffem,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is LuckyWheelError) {
              return Center(child: Text('Lỗi: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
