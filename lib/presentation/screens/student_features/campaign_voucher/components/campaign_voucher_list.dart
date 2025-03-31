// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
// import 'package:swallet_mobile/domain/interface_repositories/student_features/campaign_repository.dart';
// import 'package:swallet_mobile/presentation/blocs/campaign_voucher/campaign_voucher_bloc.dart';
// import 'package:swallet_mobile/presentation/widgets/empty_widget.dart';

// import '../../../../blocs/blocs.dart';
// import '../../../../config/constants.dart';
// import '../../../../widgets/shimmer_widget.dart';

// class CampaignVoucherList extends StatelessWidget {
//   const CampaignVoucherList(
//       {super.key,
//       required this.fem,
//       required this.hem,
//       required this.ffem,
//       required this.campaignDetallModeil,
//       required this.id,
//       required this.studentId});

//   final double fem;
//   final double hem;
//   final double ffem;
//   final CampaignDetailModel campaignDetallModeil;
//   final String id;
//   final String studentId;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CampaignVoucherBloc(
//           campaignRepository: context.read<CampaignRepository>())
//         ..add(LoadCampaignVoucher(id: campaignDetallModeil.id)),
//       child: BlocBuilder<CampaignVoucherBloc, CampaignVoucherState>(
//         builder: (context, state) {
//           if (state is CampaignVoucherLoading) {
//             return buildCampaignListShimmer(fem, hem);
//           } else if (state is CampaignVouchersLoaded) {
//             var listCampaignVouchers =
//                 state.campaignVouchers.where((c) => (c.id != id)).toList();
//             if (listCampaignVouchers.isEmpty) {
//               return Container(
//                   margin: EdgeInsets.only(top: 10 * hem),
//                   child: EmptyWidget(text: 'Không có ưu đãi'));
//             } else {
//               return Container(
//                   height: 240 * hem,
//                   margin: EdgeInsets.only(left: 15 * fem),
//                   width: MediaQuery.of(context).size.width,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: listCampaignVouchers.length,
//                     itemBuilder: (context, index) {
//                       // var campaignVoucher = listCampaignVouchers[index];
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(
//                               context, CampaignVoucherScreen.routeName,
//                               arguments: <dynamic>[
//                                 campaignDetallModeil,
//                                 listCampaignVouchers[index],
//                                 studentId
//                               ]);
//                         },
//                         child: Stack(
//                           children: [
//                             Container(
//                               width: 170 * fem,
//                               margin: EdgeInsets.only(right: 10 * fem),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15 * fem),
//                                   color: Colors.white,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Color(0xFF757575).withOpacity(0.3),
//                                       blurRadius: 10.0, // soften the shadow
//                                       spreadRadius: 1.0, //extend the shadow
//                                       offset: const Offset(
//                                         5.0,
//                                         5.0,
//                                       ),
//                                     )
//                                   ]),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     padding: EdgeInsets.only(
//                                         top: 5 * hem,
//                                         right: 5 * fem,
//                                         left: 5 * fem),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(10 * fem),
//                                           topRight: Radius.circular(10 * fem)),
//                                       child: Container(
//                                         height: 150 * hem,
//                                         width: 180 * fem,
//                                         child: Image.network(
//                                          listCampaignVouchers[index]
//                                               .voucherImage,
//                                           fit: BoxFit.fill,
//                                           errorBuilder:
//                                               (context, error, stackTrace) {
//                                             return Container(
//                                               child: Image.asset(
//                                                   'assets/images/image-404.jpg'),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.only(
//                                         left: 10 * fem,
//                                         right: 10 * fem,
//                                         top: 10 * hem),
//                                     child: Text(
//                                      listCampaignVouchers[index].voucherName,
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 2,
//                                       style: GoogleFonts.openSans(
//                                           textStyle: TextStyle(
//                                         fontSize: 13 * ffem,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w500,
//                                       )),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 5 * fem,
//                               child: Container(
//                                 width: 172 * fem,
//                                 padding: EdgeInsets.only(
//                                     left: 10 * fem, right: 10 * fem),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(
//                                           '${formatter.format(listCampaignVouchers[index].price)}',
//                                           style: GoogleFonts.openSans(
//                                               textStyle: TextStyle(
//                                             fontSize: 16 * ffem,
//                                             color: kPrimaryColor,
//                                             fontWeight: FontWeight.bold,
//                                           )),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 2 * fem,
//                                               top: 2 * hem,
//                                               bottom: 0 * hem),
//                                           child: SvgPicture.asset(
//                                             'assets/icons/green-bean-icon.svg',
//                                             width: 22 * fem,
//                                             height: 20 * fem,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           '${listCampaignVouchers[index].quantityInStock}',
//                                           style: GoogleFonts.openSans(
//                                               textStyle: TextStyle(
//                                             fontSize: 14 * ffem,
//                                             color: kPrimaryColor,
//                                             fontWeight: FontWeight.normal,
//                                           )),
//                                         ),
//                                         Padding(
//                                           padding:
//                                               EdgeInsets.only(right: 5 * fem),
//                                           child: Text(
//                                             '/${listCampaignVouchers[index].quantity}',
//                                             style: GoogleFonts.openSans(
//                                                 textStyle: TextStyle(
//                                               fontSize: 14 * ffem,
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.normal,
//                                             )),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ));
//             }
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }

// Widget buildCampaignListShimmer(double fem, double hem) {
//   return Row(
//     children: [
//       Container(
//         margin: EdgeInsets.only(left: 15 * fem, top: 20 * hem),
//         child: ShimmerWidget.rectangular(
//           height: 200 * hem,
//           width: 170 * fem,
//         ),
//       ),
//       Container(
//         margin: EdgeInsets.only(left: 15 * fem, top: 20 * hem),
//         child: ShimmerWidget.rectangular(
//           height: 200 * hem,
//           width: 170 * fem,
//         ),
//       ),
//     ],
//   );
// }
