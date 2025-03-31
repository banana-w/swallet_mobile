// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
// import 'package:swallet_mobile/data/models/student_features/campaign_voucher_model.dart';
// import 'package:swallet_mobile/data/models/student_features/student_model.dart';
// import 'package:swallet_mobile/domain/interface_repositories/student_features/campaign_repository.dart';
// import 'package:swallet_mobile/domain/interface_repositories/student_features/student_repository.dart';
// import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';
// import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
// import 'package:swallet_mobile/presentation/config/constants.dart';

// import '../../../../data/datasource/authen_local_datasource.dart';
// import '../../../blocs/blocs.dart';
// import 'components/body.dart';

// class CampaignVoucherScreen extends StatelessWidget {
//   static const String routeName = '/campaign-voucher-detail-student';

//   static Route route(
//       {required CampaignVoucherModel campaignVoucher,
//       required CampaignDetailModel campaignDetail,
//       required String studentId}) {
//     return MaterialPageRoute(
//         builder: (_) => BlocProvider(
//               create: (context) => CampaignBloc(
//                   campaignRepository: context.read<CampaignRepository>())
//                 ..add(LoadCampaigns()),
//               child: CampaignVoucherScreen(
//                 campaignDetailModel: campaignDetail,
//                 campaignVoucherModel: campaignVoucher,
//                 studentId: studentId,
//               ),
//             ),
//         settings: const RouteSettings(arguments: routeName));
//   }

//   const CampaignVoucherScreen(
//       {super.key,
//       required this.campaignVoucherModel,
//       required this.campaignDetailModel,
//       required this.studentId});

//   final CampaignVoucherModel campaignVoucherModel;
//   final CampaignDetailModel campaignDetailModel;
//   final String studentId;

//   @override
//   Widget build(BuildContext context) {
//     double baseWidth = 375;
//     double fem = MediaQuery.of(context).size.width / baseWidth;
//     double baseHeight = 812;
//     double ffem = fem * 0.97;
//     double hem = MediaQuery.of(context).size.height / baseHeight;
//     return BlocProvider(
//       create: (context) =>
//           StudentBloc(studentRepository: context.read<StudentRepository>())
//             ..add(LoadStudentById(accountId: studentId)),
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: klighGreyColor,
//           appBar: AppBar(
//             elevation: 0,
//             flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage('assets/images/background_splash.png'),
//                       fit: BoxFit.cover)),
//             ),
//             leading: InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Icon(
//                 Icons.arrow_back_rounded,
//                 color: Colors.white,
//                 size: 25 * fem,
//               ),
//             ),
//             toolbarHeight: 50 * hem,
//             centerTitle: true,
//             title: Text(
//               'Chi tiết ưu đãi',
//               style: GoogleFonts.openSans(
//                   textStyle: TextStyle(
//                       fontSize: 18 * ffem,
//                       fontWeight: FontWeight.w900,
//                       height: 1.3625 * ffem / fem,
//                       color: Colors.white)),
//             ),
//             actions: [
//               // SvgPicture.asset('assets/icons/notification-icon.svg')
//               Padding(
//                 padding: EdgeInsets.only(right: 20 * fem),
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.home,
//                     color: Colors.white,
//                     size: 25 * fem,
//                   ),
//                   onPressed: () {
//                     Navigator.pushNamedAndRemoveUntil(context,
//                         '/landing-screen', (Route<dynamic> route) => false);
//                   },
//                 ),
//               ),
//             ],
//           ),
//           bottomNavigationBar: BlocBuilder<CampaignBloc, CampaignState>(
//             builder: (context, state) {
//               if (state is CampaignsLoaded) {
//                 var containCampaign =
//                     state.campaigns.where((c) => c.id == campaignDetailModel.id).toList();
//                 if (containCampaign.isNotEmpty) {
//                   return MultiBlocProvider(
//                     providers: [
//                       BlocProvider(
//                         create: (context) => CounterCubit(),
//                       ),
//                       BlocProvider(
//                         create: (context) => CampaignBloc(
//                             campaignRepository:
//                                 context.read<CampaignRepository>()),
//                       ),
//                     ],
//                     child: BottomAppBar(
//                       color: Colors.white,
//                       height: 110 * hem,
//                       elevation: 50,
//                       child: BlocBuilder<CounterCubit, CounterState>(
//                         builder: (context, state) {
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Tổng đậu xanh',
//                                     style: GoogleFonts.openSans(
//                                         textStyle: TextStyle(
//                                             fontSize: 15 * ffem,
//                                             fontWeight: FontWeight.w500,
//                                             color: Colors.black)),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         '${formatter.format((campaignVoucherModel.price) * state.counterValue)}',
//                                         style: GoogleFonts.openSans(
//                                             textStyle: TextStyle(
//                                           fontSize: 25 * ffem,
//                                           color: kPrimaryColor,
//                                           fontWeight: FontWeight.bold,
//                                         )),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 2 * fem,
//                                             top: 4 * hem,
//                                             bottom: 0 * hem),
//                                         child: SvgPicture.asset(
//                                           'assets/icons/green-bean-icon.svg',
//                                           width: 30 * fem,
//                                           height: 30 * fem,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         width: 25 * fem,
//                                         height: 25 * fem,
//                                         child: FloatingActionButton(
//                                             heroTag: 'remove',
//                                             elevation: 0,
//                                             backgroundColor: klightPrimaryColor,
//                                             child: const Icon(
//                                               Icons.remove,
//                                               size: 15,
//                                             ),
//                                             onPressed: () {
//                                               if (state.counterValue <= 1) {
//                                               } else {
//                                                 context
//                                                     .read<CounterCubit>()
//                                                     .decrement();
//                                               }
//                                             }),
//                                       ),
//                                       Container(
//                                         margin: EdgeInsets.only(
//                                           right: 10 * fem,
//                                           left: 10 * fem,
//                                         ),
//                                         width: 40 * fem,
//                                         height: 30 * hem,
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(5),
//                                             color: kbgWhiteColor),
//                                         child: Center(
//                                             child: Text(
//                                           '${state.counterValue}',
//                                           style: GoogleFonts.openSans(
//                                               textStyle: TextStyle(
//                                                   fontSize: 12 * ffem,
//                                                   fontWeight: FontWeight.normal,
//                                                   color: Colors.black)),
//                                         )),
//                                       ),
//                                       Container(
//                                         width: 25 * fem,
//                                         height: 25 * fem,
//                                         child: FloatingActionButton(
//                                             heroTag: 'Add',
//                                             elevation: 0,
//                                             backgroundColor: klightPrimaryColor,
//                                             child: const Icon(
//                                               Icons.add,
//                                               size: 15,
//                                             ),
//                                             onPressed: () {
//                                               if (state.counterValue >=
//                                                   campaignVoucherModel
//                                                       .quantityInStock) {
//                                               } else {
//                                                 context
//                                                     .read<CounterCubit>()
//                                                     .increment();
//                                               }
//                                             }),
//                                       ),
//                                     ],
//                                   ),
//                                   BlocBuilder<StudentBloc, StudentState>(
//                                     builder: (context, stateStudent) {
//                                       if (stateStudent is StudentByIdSuccess) {
//                                         return buildButtonBuy(
//                                             context,
//                                             state,
//                                             fem,
//                                             hem,
//                                             ffem,
//                                             stateStudent.studentMode);
//                                       }
//                                       return Container(
//                                         width: 200 * fem,
//                                         height: 35 * hem,
//                                         decoration: BoxDecoration(
//                                             color: kLowTextColor,
//                                             borderRadius: BorderRadius.circular(
//                                                 10 * fem)),
//                                         child: Center(
//                                           child: Text(
//                                             'Mua ngay',
//                                             style: GoogleFonts.openSans(
//                                                 textStyle: TextStyle(
//                                                     fontSize: 15 * ffem,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.white)),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   );
//                 } else {
//                   return BottomAppBar(
//                     color: Colors.white,
//                     height: 110 * hem,
//                     elevation: 50,
//                     child: Center(
//                       child: Text(
//                         'Bạn không thể mua vì ưu đãi này thuộc trong chiến dịch mà bạn không được tham gia.',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.openSans(
//                             textStyle: TextStyle(
//                                 fontSize: 15 * ffem,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black)),
//                       ),
//                     ),
//                   );
//                 }
//               }
//               return BottomAppBar(
//                   color: Colors.white,
//                   height: 110 * hem,
//                   elevation: 50,
//                   child: Container(
//                     child: Center(
//                       child: CircularProgressIndicator(
//                         color: kPrimaryColor,
//                       ),
//                     ),
//                   ));
//             },
//           ),
//           body: Body(
//             campaignVoucherModel: campaignVoucherModel,
//             campaignDetil: campaignDetailModel,
//             studentId: studentId,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildButtonBuy(BuildContext context, CounterState state, double fem,
//       double hem, double ffem, StudentModel student) {
//     final stateName = student.state;
//     if (stateName == 'Pending' || stateName == 'Rejected') {
//       return Container(
//         width: 200 * fem,
//         height: 35 * hem,
//         decoration: BoxDecoration(
//             color: kLowTextColor,
//             borderRadius: BorderRadius.circular(10 * fem)),
//         child: Center(
//           child: Text(
//             'Mua ngay',
//             style: GoogleFonts.openSans(
//                 textStyle: TextStyle(
//                     fontSize: 15 * ffem,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white)),
//           ),
//         ),
//       );
//     } else {
//       if (campaignVoucherModel.quantityInStock == 0) {
//         return Container(
//           width: 200 * fem,
//           height: 35 * hem,
//           decoration: BoxDecoration(
//               color: kLowTextColor,
//               borderRadius: BorderRadius.circular(10 * fem)),
//           child: Center(
//             child: Text(
//               'Hết ưu đãi',
//               style: GoogleFonts.openSans(
//                   textStyle: TextStyle(
//                       fontSize: 15 * ffem,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white)),
//             ),
//           ),
//         );
//       } else if ((campaignDetailModel.startOn
//               .compareTo(DateTime.now().toString()) >
//           0)) {
//         return Container(
//           width: 200 * fem,
//           height: 35 * hem,
//           decoration: BoxDecoration(
//               color: kLowTextColor,
//               borderRadius: BorderRadius.circular(10 * fem)),
//           child: Center(
//             child: Text(
//               'Sắp diễn ra',
//               style: GoogleFonts.openSans(
//                   textStyle: TextStyle(
//                       fontSize: 15 * ffem,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white)),
//             ),
//           ),
//         );
//       } else {
//         return InkWell(
//             onTap: () async {
//               final student = await AuthenLocalDataSource.getStudent();
//               if (student!.greenWalletBalance <
//                   (campaignVoucherModel.price * state.counterValue)) {
//                 ScaffoldMessenger.of(context)
//                   ..hideCurrentSnackBar()
//                   ..showSnackBar(SnackBar(
//                     elevation: 0,
//                     duration: const Duration(milliseconds: 2000),
//                     behavior: SnackBarBehavior.floating,
//                     backgroundColor: Colors.transparent,
//                     content: AwesomeSnackbarContent(
//                       title: 'Mua thất bại',
//                       message: 'Số đậu xanh của bạn không đủ!',
//                       contentType: ContentType.failure,
//                     ),
//                   ));
//               } else {
//                 final studentId = await AuthenLocalDataSource.getStudentId();

//                 Navigator.pushNamed(context, RedeemVoucherScreen.routeName,
//                     arguments: <dynamic>[
//                       campaignDetailModel.id,
//                       campaignVoucherModel.id,
//                       studentId!,
//                       state.counterValue,
//                       'string',
//                       campaignDetailModel.campaignName,
//                       (campaignVoucherModel.price * state.counterValue),
//                       campaignVoucherModel.voucherName,
//                       campaignVoucherModel.price
//                     ]);
//               }
//             },
//             child: Container(
//               width: 200 * fem,
//               height: 35 * hem,
//               decoration: BoxDecoration(
//                   color: kPrimaryColor,
//                   borderRadius: BorderRadius.circular(10 * fem)),
//               child: Center(
//                 child: Text(
//                   'Mua ngay',
//                   style: GoogleFonts.openSans(
//                       textStyle: TextStyle(
//                           fontSize: 15 * ffem,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white)),
//                 ),
//               ),
//             ));
//       }
//     }
//   }
// }
