// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:swallet_mobile/data/models/student_features/student_model.dart';
// import 'package:swallet_mobile/presentation/config/constants.dart';

// class MemberShipCard extends StatelessWidget {
//   const MemberShipCard({
//     super.key,
//     required this.fem,
//     required this.hem,
//     required this.ffem,
//     required this.heightText,
//     required this.studentModel,
//   });

//   final double fem;
//   final double hem;
//   final double ffem;
//   final double heightText;
//   final StudentModel studentModel;

//   @override
//   Widget build(BuildContext context) {
//     var formatter = NumberFormat('###,000');
//     return Center(
//       child: SizedBox(
//         width: 340 * fem,
//         height: 200 * hem,
//         child: Stack(
//           children: [
//             Container(
//               width: 330 * fem,
//               height: 200 * hem,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20 * fem),
//                   boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black26,
//                                 blurRadius: 5.0,
//                                 offset: Offset(3.0, 2),
//                               ),
//                             ],
//                   image: DecorationImage(
//                       image: AssetImage('assets/images/bg-card-level.png'),
//                       fit: BoxFit.cover)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(top: 25 * hem, left: 35 * fem),
//                     child: Container(
//                       // color: Colors.red,
//                       width: 250 * fem,
//                       child: Text(
//                         'Xin Chào,\n   ${studentModel.fullName}',
//                         style: GoogleFonts.openSans(
//                             textStyle: TextStyle(
//                           fontSize: 18 * ffem,
//                           height: heightText,
//                           color: kPrimaryColor,
//                           fontWeight: FontWeight.bold,
//                         )),
//                       ),
//                     ),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(top: 20 * hem, left: 50 * fem),
//                         child: Text(
//                           'Số dư:',
//                           style: GoogleFonts.openSans(
//                               textStyle: TextStyle(
//                             fontSize: 18 * ffem,
//                             height: heightText,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           )),
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Padding(
//                             padding:
//                                 EdgeInsets.only(left: 20 * fem, top: 0 * hem),
//                             child: Row(
//                               children: [
//                                 studentModel.greenWalletBalance == 0
//                                     ? Text(
//                                         '${studentModel.greenWalletBalance.toStringAsFixed(0)}',
//                                         style: GoogleFonts.openSans(
//                                             textStyle: TextStyle(
//                                           fontSize: 18 * ffem,
//                                           height: heightText,
//                                           color: kPrimaryColor,
//                                           fontWeight: FontWeight.bold,
//                                         )),
//                                       )
//                                     : Text(
//                                         '${formatter.format(studentModel.greenWalletBalance)}',
//                                         style: GoogleFonts.openSans(
//                                             textStyle: TextStyle(
//                                           fontSize: 18 * ffem,
//                                           height: heightText,
//                                           color: kPrimaryColor,
//                                           fontWeight: FontWeight.bold,
//                                         )),
//                                       ),
//                                 SvgPicture.asset(
//                                   'assets/icons/green-bean-icon.svg',
//                                   width: 25 * fem,
//                                   height: 30 * fem,
//                                 )
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsets.only(right: 20 * fem, top: 0 * hem),
//                             child: Row(
//                               children: [
//                                 studentModel.redWalletBalance == 0
//                                     ? Text(
//                                         '${studentModel.redWalletBalance.toStringAsFixed(0)}',
//                                         style: GoogleFonts.openSans(
//                                             textStyle: TextStyle(
//                                           fontSize: 18 * ffem,
//                                           height: heightText,
//                                           color: Colors.red,
//                                           fontWeight: FontWeight.bold,
//                                         )),
//                                       )
//                                     : Text(
//                                         '${formatter.format(studentModel.redWalletBalance)}',
//                                         style: GoogleFonts.openSans(
//                                             textStyle: TextStyle(
//                                           fontSize: 18 * ffem,
//                                           height: heightText,
//                                           color: Colors.red,
//                                           fontWeight: FontWeight.bold,
//                                         )),
//                                       ),
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2 * fem, bottom: 4 * hem),
//                                   child: SvgPicture.asset(
//                                     'assets/icons/red-bean-icon.svg',
//                                     width: 25 * fem,
//                                     height: 22 * fem,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 150 * hem,
//               left: 240 * fem,
//               child: Container(
//                 width: 100 * fem,
//                 height: 40 * fem,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5 * fem),
//                     color: kDarkPrimaryColor),
//                 child: Center(
//                   child: Text(
//                     'MSSV: ${studentModel.code}',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.openSans(
//                       color: Colors.white,
//                       height: heightText,
//                       fontSize: 13 * ffem,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 10 * hem,
//               right: 25 * fem,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(45),
//                 child: Container(
//                   width: 90 * fem,
//                   height: 90 * hem,
//                   child: Image.network(
//                     '${studentModel.avatar}',
//                     fit: BoxFit.fill,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Image.asset('assets/images/ava_signup.png');
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
