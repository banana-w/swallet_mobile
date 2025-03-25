import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/voucher_student_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign_voucher_list/campaign_voucher_list_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/qr/qr_voucher_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher_item_detail/voucher_item_detail_screen.dart';
import 'package:swallet_mobile/presentation/widgets/paint_voucher_card.dart';

import '../../../../data/models.dart';
import '../../../blocs/blocs.dart';
import '../../screens.dart';

class VoucherListScreen extends StatelessWidget {
  static const String routeName = '/voucher-list-student';

  static Route route({required String search, required String studentId}) {
    return MaterialPageRoute(
      builder: (_) => VoucherListScreen(search: search, studentId: studentId),
      settings: const RouteSettings(arguments: routeName),
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
    double baseHeight = 812;
    double ffem = fem * 0.97;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return BlocProvider(
      create:
          (context) => StudentBloc(
            studentRepository: context.read<StudentRepository>(),
          )..add(
            LoadStudentVouchers(search: search, id: studentId, isUsed: true),
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
            actions: [
              // SvgPicture.asset('assets/icons/notification-icon.svg')
              Padding(
                padding: EdgeInsets.only(right: 20 * fem),
                child: IconButton(
                  icon: Icon(Icons.home, color: Colors.white, size: 25 * fem),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/landing-screen',
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
            ],
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
  @override
  void initState() {
    scrollController.addListener(() {
      context.read<StudentBloc>().add(
        LoadMoreStudentVouchers(
          scrollController,
          id: widget.studentId,
          search: widget.search,
          isUsed: false,
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            BlocBuilder<StudentBloc, StudentState>(
              builder: (context, state) {
                if (state is StudentVoucherLoading) {
                  return buildVoucherShimmer(3, widget.fem, widget.hem);
                } else if (state is StudentVouchersLoaded) {
                  if (state.voucherModels.isEmpty) {
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        left: 15 * widget.fem,
                        right: 15 * widget.fem,
                        top: 20,
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
                            'assets/icons/empty-icon.svg',
                            width: 80 * widget.fem,
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
                        ],
                      ),
                    );
                  } else {
                    final vouchers = state.voucherModels;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        Container(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                state.hasReachedMax
                                    ? vouchers.length
                                    : vouchers.length + 1,
                            itemBuilder: (context, index) {
                              if (index >= state.voucherModels.length) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: kPrimaryColor,
                                  ),
                                );
                              } else {
                                var studentVoucher = vouchers[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x0c000000),
                                        offset: Offset(
                                          3 * widget.fem,
                                          2 * widget.fem,
                                        ),
                                        blurRadius: 5 * widget.fem,
                                      ),
                                    ],
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.18,
                                  margin: EdgeInsets.only(
                                    bottom: 15,
                                    left: 15,
                                    right: 15,
                                  ),
                                  width: double.infinity,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        VoucherItemDetailScreen.routeName,
                                        arguments: studentVoucher,
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                color: kPrimaryColor,
                                                child: Center(
                                                  child: RotatedBox(
                                                    quarterTurns: 3,
                                                    child: Text(
                                                      studentVoucher.brandName,
                                                      style:
                                                          GoogleFonts.openSans(
                                                            textStyle: TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                color: Colors.white,
                                                padding: const EdgeInsets.all(
                                                  10,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      studentVoucher.voucherName,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                                MediaQuery.of(
                                                                  context,
                                                                ).size.height,
                                                            width:
                                                                MediaQuery.of(
                                                                  context,
                                                                ).size.width *
                                                                0.3,
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  flex: 2,
                                                                  child: ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          10,
                                                                        ),
                                                                    child: SizedBox(
                                                                      width:
                                                                          130 *
                                                                          widget
                                                                              .fem,
                                                                      height:
                                                                          140 *
                                                                          widget
                                                                              .hem,
                                                                      child: Image.network(
                                                                        studentVoucher
                                                                            .voucherImage,
                                                                        fit:
                                                                            BoxFit.fill,
                                                                        errorBuilder: (
                                                                          context,
                                                                          error,
                                                                          stackTrace,
                                                                        ) {
                                                                          return Icon(
                                                                            Icons.error_outlined,
                                                                            size:
                                                                                50 *
                                                                                widget.fem,
                                                                            color:
                                                                                kPrimaryColor,
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 2,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      'Ngày mua: ',
                                                                      style: GoogleFonts.openSans(
                                                                        textStyle: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child: Text(
                                                                        changeFormateDate(studentVoucher.dateBought),
                                                                        style: GoogleFonts.openSans(
                                                                          textStyle: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      'Hạn sử dụng: ',
                                                                      style: GoogleFonts.openSans(
                                                                        textStyle: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child: Text(
                                                                        changeFormateDate(studentVoucher.expireOn),
                                                                        style: GoogleFonts.openSans(
                                                                          textStyle: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                buildButtonVoucher(
                                                                  widget.hem,
                                                                  widget.fem,
                                                                  studentVoucher,
                                                                  context,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        CustomPaint(
                                          painter: SideCutsDesign(),
                                          child: SizedBox(
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.25,
                                            width: double.infinity,
                                          ),
                                        ),
                                        CustomPaint(
                                          painter: DottedInitialPath(),
                                          child: SizedBox(
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.25,
                                            width: double.infinity,
                                          ),
                                        ),
                                        CustomPaint(
                                          painter: DottedMiddlePath(),
                                          child: SizedBox(
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.25,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  }
                }
                return buildVoucherStudentShimmer(3, widget.fem, widget.hem);
              },
            ),
          ]),
        ),
      ],
    );
  }

  Widget buildButtonVoucher(
    double hem,
    double fem,
    VoucherStudentModel studentVoucher,
    context,
  ) {
    if (studentVoucher.isUsed) {
      return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            QRVoucherScreen.routeName,
            arguments: studentVoucher.voucherCode,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: klighGreyColor,
          shape: const StadiumBorder(
            side: BorderSide(width: 1, color: klowTextGrey),
          ),
        ),
        child: Text(
          'Đã sử dụng',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: klowTextGrey,
            ),
          ),
        ),
      );
    } else if (DateTime.now().isAfter(
      DateTime.parse(studentVoucher.expireOn),
    )) {
      return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            QRVoucherScreen.routeName,
            arguments: studentVoucher.voucherCode,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: klighGreyColor,
          shape: const StadiumBorder(
            side: BorderSide(width: 1, color: klowTextGrey),
          ),
        ),
        child: Text(
          'Đã quá hạn',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: klowTextGrey,
            ),
          ),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            QRVoucherScreen.routeName,
            arguments: studentVoucher.voucherCode,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const StadiumBorder(
            side: BorderSide(width: 1, color: klightPrimaryColor),
          ),
        ),
        child: Text(
          'Mã QR',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ),
        ),
      );
    }
  }
}

Widget buildVoucherStudentShimmer(count, double fem, double hem) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        width: 170 * fem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15 * fem),
          color: Colors.white,
        ),
      ),
      Container(
        width: 170 * fem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15 * fem),
          color: Colors.white,
        ),
      ),
    ],
  );
}
