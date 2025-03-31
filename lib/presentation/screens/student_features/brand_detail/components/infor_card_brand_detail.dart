// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:swallet_mobile/data/models/student_features/brand_model.dart';


// class InformationCardBrandDetail extends StatefulWidget {
//   const InformationCardBrandDetail({
//     super.key,
//     required this.hem,
//     required this.fem,
//     required this.ffem,
//     required this.brandModel,
//   });

//   final double hem;
//   final double fem;
//   final double ffem;
//   final BrandModel brandModel;

//   @override
//   State<InformationCardBrandDetail> createState() =>
//       _InformationCardBrandDetailState();
// }

// class _InformationCardBrandDetailState
//     extends State<InformationCardBrandDetail> {
//   bool isFollowed = false;
//   late int numberOfFollowers;
//   @override
//   void initState() {
//     // isFollowed = widget.brandModel.isFavor;
//     // numberOfFollowers = widget.brandModel.numberOfFollowers;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<WishlistBloc, WishlistState>(
//       listener: (context, state) {
//         if (state is CreateWishListSuccess) {
//           if (state.wishlist.status) {
//             setState(() {
//               isFollowed = true;
//             });
//             PushNotification().initNotifications();
//             PushNotification().localNotiInit();
//             ScaffoldMessenger.of(context)
//               ..hideCurrentSnackBar()
//               ..showSnackBar(SnackBar(
//                 elevation: 0,
//                 duration: const Duration(milliseconds: 2000),
//                 behavior: SnackBarBehavior.floating,
//                 backgroundColor: Colors.transparent,
//                 content: AwesomeSnackbarContent(
//                   title: 'Theo dõi thành công',
//                   message: 'Theo dõi ${state.wishlist.brandName} thành công!',
//                   contentType: ContentType.success,
//                 ),
//               ));
//           } else {
//             setState(() {
//               isFollowed = false;
//             });
//             PushNotification().initNotifications();
//             PushNotification().localNotiInit();
//             ScaffoldMessenger.of(context)
//               ..hideCurrentSnackBar()
//               ..showSnackBar(SnackBar(
//                 elevation: 0,
//                 duration: const Duration(milliseconds: 2000),
//                 behavior: SnackBarBehavior.floating,
//                 backgroundColor: Colors.transparent,
//                 content: AwesomeSnackbarContent(
//                   title: 'Hủy theo dõi thành công',
//                   message:
//                       'Hủy theo dõi ${state.wishlist.brandName} thành công!',
//                   contentType: ContentType.success,
//                 ),
//               ));
//           }
//         }
//       },
//       child: Container(
//         height: 200 * widget.hem,
//         margin: EdgeInsets.only(right: 15 * widget.fem, left: 15 * widget.fem),
//         padding: EdgeInsets.only(top: 5 * widget.hem, bottom: 5 * widget.hem),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15 * widget.fem),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                   color: Color(0x0c000000),
//                   offset: Offset(0 * widget.fem, 10 * widget.fem),
//                   blurRadius: 5 * widget.fem)
//             ]),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 10 * widget.hem,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: 25 * widget.fem,
//                 ),

//                 //avatar
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10 * widget.fem),
//                   child: Container(
//                     height: 80 * widget.hem,
//                     width: 80 * widget.fem,
//                     child: Image.network(
//                       widget.brandModel.logo,
//                       fit: BoxFit.fill,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           child: Icon(
//                             Icons.error,
//                             size: 50 * widget.fem,
//                             color: kPrimaryColor,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),

//                 SizedBox(
//                   width: 20 * widget.fem,
//                 ),

//                 SizedBox(
//                   // color: Colors.red,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       //Name
//                       SizedBox(
//                         width: 150 * widget.fem,
//                         child: Row(
//                           children: [
//                             Flexible(
//                               child: Text(
//                                 widget.brandModel.brandName,
//                                 // softWrap: true,
//                                 maxLines: 2,
//                                 style: GoogleFonts.openSans(
//                                     textStyle: TextStyle(
//                                         fontSize: 16 * widget.ffem,
//                                         fontWeight: FontWeight.w800,
//                                         height:
//                                             1.3625 * widget.ffem / widget.fem,
//                                         color: Colors.black)),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       isFollowed
//                           ? InkWell(
//                               onTap: () async {
//                                 final studentModel =
//                                     await AuthenLocalDataSource.getStudent();
//                                 if (studentModel!.state == 'Active') {
//                                   context.read<WishlistBloc>().add(
//                                       CreateWishList(
//                                           studentId: studentModel.id,
//                                           brandId: widget.brandModel.id,
//                                           description: "",
//                                           state: true));
//                                 } else {
//                                   ScaffoldMessenger.of(context)
//                                     ..hideCurrentSnackBar()
//                                     ..showSnackBar(SnackBar(
//                                       elevation: 0,
//                                       duration:
//                                           const Duration(milliseconds: 2000),
//                                       behavior: SnackBarBehavior.floating,
//                                       backgroundColor: Colors.transparent,
//                                       content: AwesomeSnackbarContent(
//                                         title: 'Theo dõi thất bại',
//                                         message: 'Bạn chưa được xét duyệt!',
//                                         contentType: ContentType.failure,
//                                       ),
//                                     ));
//                                 }
//                               },
//                               child: Container(
//                                 width: 140 * widget.fem,
//                                 height: 30 * widget.hem,
//                                 margin: EdgeInsets.only(top: 10 * widget.hem),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: kPrimaryColor, width: 2),
//                                   borderRadius:
//                                       BorderRadius.circular(5 * widget.fem),
//                                   color: Colors.white,
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.check,
//                                       color: kPrimaryColor,
//                                     ),
//                                     Text(
//                                       'Đang theo dõi',
//                                       style: GoogleFonts.openSans(
//                                         fontSize: 14 * widget.ffem,
//                                         color: kPrimaryColor,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           : InkWell(
//                               onTap: () async {
//                                 final studentModel =
//                                     await AuthenLocalDataSource.getStudent();
//                                 if (studentModel!.state == 'Active') {
//                                   context.read<WishlistBloc>().add(
//                                       CreateWishList(
//                                           studentId: studentModel.id,
//                                           brandId: widget.brandModel.id,
//                                           description: "",
//                                           state: true));
//                                 } else {
//                                   ScaffoldMessenger.of(context)
//                                     ..hideCurrentSnackBar()
//                                     ..showSnackBar(SnackBar(
//                                       elevation: 0,
//                                       duration:
//                                           const Duration(milliseconds: 2000),
//                                       behavior: SnackBarBehavior.floating,
//                                       backgroundColor: Colors.transparent,
//                                       content: AwesomeSnackbarContent(
//                                         title: 'Theo dõi thất bại',
//                                         message: 'Bạn chưa được xét duyệt!',
//                                         contentType: ContentType.failure,
//                                       ),
//                                     ));
//                                 }
//                               },
//                               child: Container(
//                                 width: 100 * widget.fem,
//                                 height: 30 * widget.hem,
//                                 margin: EdgeInsets.only(top: 10 * widget.hem),
//                                 decoration: BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.circular(5 * widget.fem),
//                                   color: kPrimaryColor,
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     'Theo dõi',
//                                     style: GoogleFonts.openSans(
//                                       fontSize: 14 * widget.ffem,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       height: 1.3625 * widget.ffem / widget.fem,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10 * widget.fem,
//             ),
//             SizedBox(
//               width: 280 * widget.fem,
//               child: Divider(
//                 thickness: 1 * widget.fem,
//                 color: const Color.fromARGB(255, 225, 223, 223),
//               ),
//             ),
//             BlocProvider(
//               create: (context) =>
//                   BrandBloc(brandRepository: context.read<BrandRepository>())
//                     ..add(LoadBrandById(id: widget.brandModel.id)),
//               child: OthersInforBrandDetail(
//                 hem: widget.hem,
//                 fem: widget.fem,
//                 ffem: widget.ffem,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
