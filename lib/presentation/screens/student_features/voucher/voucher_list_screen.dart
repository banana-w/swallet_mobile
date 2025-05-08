import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/landing_screen/landing_screen_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/components/tab_voucher.dart';


class VoucherListScreen extends StatelessWidget {
  static const String routeName = '/voucher-list-student';

  static Route route({required String search, required String studentId}) {
    return MaterialPageRoute(
      builder: (_) => VoucherListScreen(search: search, studentId: studentId),
      settings: const RouteSettings(name: routeName),
    );
  }

  const VoucherListScreen({
    super.key,
    required this.search,
    required this.studentId,
  });
  final String search;
  final String studentId;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return BlocProvider(
      create: (context) => StudentBloc(
        studentRepository: context.read<StudentRepository>(),
      )..add(
          LoadStudentVouchers(search: search, id: studentId, isUsed: false),
        ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: klighGreyColor,
          appBar: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_splash.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 25 * fem,
              ),
            ),
            toolbarHeight: 50 * hem,
            centerTitle: true,
            title: Text(
              'Kết quả tìm kiếm',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.w900,
                  height: 1.3625 * ffem / fem,
                  color: Colors.white,
                ),
              ),
            ),
            // actions: [
            //   Padding(
            //     padding: EdgeInsets.only(right: 20 * fem),
            //     child: IconButton(
            //       icon: Icon(Icons.home, color: Colors.white, size: 25 * fem),
            //       onPressed: () {
            //         Navigator.pushNamedAndRemoveUntil(
            //           context,
            //           '/landing-screen',
            //           (Route<dynamic> route) => false,
            //         );
            //       },
            //     ),
            //   ),
            // ],
          ),
          body: BodyVoucherList(
            fem: fem,
            hem: hem,
            ffem: ffem,
            search: search,
            studentId: studentId,
          ),
        ),
      ),
    );
  }
}

class BodyVoucherList extends StatefulWidget {
  const BodyVoucherList({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.search,
    required this.studentId,
  });

  final double fem;
  final double hem;
  final double ffem;
  final String search;
  final String studentId;

  @override
  State<BodyVoucherList> createState() => _BodyVoucherListState();
}

class _BodyVoucherListState extends State<BodyVoucherList> {
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    scrollController.addListener(() {
      final state = context.read<StudentBloc>().state;
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore &&
          state is StudentVouchersLoaded1 &&
          !state.hasReachedMax) {
        isLoadingMore = true;
        context.read<StudentBloc>().add(
              LoadMoreStudentVouchers(
                scrollController,
                id: widget.studentId,
                search: widget.search,
                isUsed: false,
              ),
            );
      }
    });

    context.read<StudentBloc>().stream.listen((state) {
      if (state is StudentVouchersLoaded1) {
        setState(() {
          isLoadingMore = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is Connected) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Đã kết nối internet',
                  message: 'Đã kết nối internet!',
                  contentType: ContentType.success,
                ),
              ),
            );
        } else if (state is NotConnected) {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text('Không kết nối Internet'),
                content: const Text('Vui lòng kết nối Internet'),
                actions: [
                  TextButton(
                    onPressed: () {
                      final stateInternet = context.read<InternetBloc>().state;
                      if (stateInternet is Connected) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Đồng ý'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<StudentBloc>().add(
                LoadStudentVouchers(
                  search: widget.search,
                  id: widget.studentId,
                  isUsed: false,
                ),
              );
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                BlocBuilder<StudentBloc, StudentState>(
                  builder: (context, state) {
                    if (state is StudentVoucherLoading) {
                      return Center(
                        child: Lottie.asset(
                          'assets/animations/loading-screen.json',
                        ),
                      );
                    } else if (state is StudentVouchersLoaded1) {
                      if (state.brandVoucherModels.isEmpty) {
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            left: 15 * widget.fem,
                            right: 15 * widget.fem,
                            top: 20 * widget.hem,
                          ),
                          height: 220 * widget.hem,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/voucher-navbar-icon.svg',
                                width: 60 * widget.fem,
                                colorFilter: ColorFilter.mode(
                                  kLowTextColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Không tìm thấy ưu đãi',
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10 * widget.fem),
                              TextButton(
                                onPressed: () {
                                  context.read<LandingScreenBloc>().add(
                                        TabChange(tabIndex: 0),
                                      );
                                },
                                child: Container(
                                  width: 180 * widget.fem,
                                  height: 45 * widget.hem,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: kPrimaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      15 * widget.fem,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Khám phá ngay',
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontSize: 15 * widget.ffem,
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        final vouchers = state.brandVoucherModels;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 15 * widget.hem),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.hasReachedMax
                                  ? vouchers.length
                                  : vouchers.length + 1,
                              itemBuilder: (context, index) {
                                if (index >= vouchers.length) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    ),
                                  );
                                }
                                var brandVoucher = vouchers[index];
                                return Container(
                                  margin: EdgeInsets.only(
                                    bottom: 15,
                                    left: 15,
                                    right: 15,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 10 * widget.fem,
                                        ),
                                        child: Text(
                                          brandVoucher.brandName,
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              fontSize: 18 * widget.ffem,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            brandVoucher.voucherGroups.length,
                                        itemBuilder: (context, voucherIndex) {
                                          var voucherGroup = brandVoucher
                                              .voucherGroups[voucherIndex];
                                          return Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      const Color(0x0c000000),
                                                  offset: Offset(
                                                    3 * widget.fem,
                                                    2 * widget.fem,
                                                  ),
                                                  blurRadius: 5 * widget.fem,
                                                ),
                                              ],
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.18,
                                            margin: EdgeInsets.only(bottom: 10),
                                            width: double.infinity,
                                            child: VoucherCard(
                                              voucherGroup: voucherGroup,
                                              brandName: brandVoucher.brandName,
                                              fem: widget.fem,
                                              hem: widget.hem,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }
                    }
                    return Center(
                      child: Lottie.asset(
                        'assets/animations/loading-screen.json',
                      ),
                    );
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}