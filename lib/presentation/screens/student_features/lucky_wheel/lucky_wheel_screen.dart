import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/student_features/lucky_prize_model.dart';
import 'package:swallet_mobile/data/repositories/student_features/lucky_prize_repository.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/lucky/lucky_wheel_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/lucky/lucky_wheel_event.dart';
import 'package:swallet_mobile/presentation/blocs/lucky/lucky_wheel_state.dart';

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
      child: const LuckyWheelView(),
    );
  }
}

class LuckyWheelView extends StatefulWidget {
  const LuckyWheelView({super.key});

  @override
  State<LuckyWheelView> createState() => _LuckyWheelViewState();
}

class _LuckyWheelViewState extends State<LuckyWheelView> {
  final StreamController<int> _controller = StreamController<int>();
  String _selectedPrize = '';
  bool _isSpinning = false;
  LuckyPrize? _selectedLuckyPrize; // Lưu phần thưởng được chọn

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void _spinWheel(List<LuckyPrize> prizes) async {
    if (!_isSpinning) {
      setState(() {
        _isSpinning = true;
        _selectedPrize = '';
        _selectedLuckyPrize = null;
      });

      // Tính toán xác suất để chọn phần thưởng
      final randomIndex = _selectPrizeIndex(prizes);
      _controller.add(randomIndex);

      Future.delayed(const Duration(seconds: 4), () async {
        final selectedPrize = prizes[randomIndex];
        setState(() {
          _selectedPrize = selectedPrize.prizeName;
          _selectedLuckyPrize = selectedPrize;
          _isSpinning = false;
        });

        // Cập nhật quantity trong database
        if (selectedPrize.quantity > 0) {
          await context.read<LuckyPrizeRepository>().updatePrizeQuantity(
            selectedPrize.id,
            selectedPrize.quantity - 1,
          );
        }

        // Nếu phần thưởng có value > 0 (dạng "XXX Xu"), gọi API để cộng điểm
        if (selectedPrize.value > 0) {
          try {
            final student = await AuthenLocalDataSource.getStudent();
            final studentId = student?.id;
            if (studentId != null) {
              await context.read<StudentRepository>().updateWalletByStudentId(
                studentId,
                selectedPrize.value,
              );
              // Hiển thị thông báo thành công
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(
              //       'Đã cộng ${selectedPrize.value} Xu vào ví của bạn!',
              //     ),
              //   ),
              // );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    elevation: 0,
                    duration: const Duration(milliseconds: 2000),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Xin chúc mừng!',
                      message:
                          'Đã cộng ${selectedPrize.value} Xu vào ví của bạn!',
                      contentType: ContentType.success,
                    ),
                  ),
                );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Không tìm thấy studentId')),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
          }
        }

        // _showResultDialog();
      });
    }
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

    double cumulativeProbability = 0;
    for (int i = 0; i < prizes.length; i++) {
      cumulativeProbability += prizes[i].probability;
      if (randomValue <= cumulativeProbability) {
        return i;
      }
    }
    return prizes.length - 1;
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Kết quả',
              style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            content: Text(
              _selectedPrize.isNotEmpty
                  ? 'Chúc mừng! Bạn đã được cộng ${_selectedLuckyPrize?.value ?? 0} Xu vào ví!'
                  : 'Đang quay...',
              style: GoogleFonts.openSans(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: GoogleFonts.openSans(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
    );
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
        backgroundColor: Colors.green,
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
            colors: [Colors.green, Colors.white],
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
                          setState(() {
                            _isSpinning = false;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 30 * hem),
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
                    // SizedBox(height: 20 * hem),
                    // if (_selectedPrize.isNotEmpty)
                    //   Text(
                    //     'Kết quả: $_selectedPrize',
                    //     style: GoogleFonts.openSans(
                    //       fontSize: 16 * ffem,
                    //       fontWeight: FontWeight.w600,
                    //       color: Colors.black,
                    //     ),
                    //   ),
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
