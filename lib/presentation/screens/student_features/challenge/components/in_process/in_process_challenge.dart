// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lottie/lottie.dart';
// import 'package:unibean_app/presentation/widgets/empty_widget.dart';

// import '../../../../../blocs/blocs.dart';
// import '../../../../../config/constants.dart';
// import '../challenge_card.dart';

// class InProcessChallenge extends StatelessWidget {
//   const InProcessChallenge({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double baseWidth = 375;
//     double fem = MediaQuery.of(context).size.width / baseWidth;
//     double ffem = fem * 0.97;
//     double baseHeight = 812;
//     double hem = MediaQuery.of(context).size.height / baseHeight;
//     return BlocListener<ChallengeBloc, ChallengeState>(
//       listener: (context, state) {
//         if (state is ChallengesLoaded) {
//           if (state.isClaimed) {
//             ScaffoldMessenger.of(context)
//               ..hideCurrentSnackBar()
//               ..showSnackBar(SnackBar(
//                 elevation: 0,
//                 duration: const Duration(milliseconds: 2000),
//                 behavior: SnackBarBehavior.floating,
//                 backgroundColor: Colors.transparent,
//                 content: AwesomeSnackbarContent(
//                   title: 'Nhận thưởng',
//                   message: 'Nhận thưởng thành công!',
//                   contentType: ContentType.success,
//                 ),
//               ));
//           }
//         } else if (state is ClaimLoading) {
//           showDialog<String>(
//               context: context,
//               builder: (BuildContext context) {
//                 Future.delayed(Duration(seconds: 5));
//                 return AlertDialog(
//                     content: Container(
//                         width: 250,
//                         height: 250,
//                         child: Center(
//                             child: CircularProgressIndicator(
//                                 color: kPrimaryColor))));
//               });
//         }
//       },
//       child: RefreshIndicator(
//         onRefresh: () async {
//           context.read<ChallengeBloc>().add(LoadChallenge());
//         },
//         child: CustomScrollView(
//           slivers: [
//             SliverList(
//               delegate: SliverChildListDelegate([
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       BlocBuilder<ChallengeBloc, ChallengeState>(
//                         builder: (context, state) {
//                           if (state is ChallengeLoading) {
//                             return Center(
//                               child: Lottie.asset(
//                                   'assets/animations/loading-screen.dart'),
//                             );
//                           } else if (state is ChallengesLoaded) {
//                             final challenges = state.challenge
//                                 .where((c) => (c.isClaimed == false))
//                                 .toList();
//                             if (challenges.isEmpty) {
//                               return EmptyWidget(text: 'Không có thử thách');
//                             } else {
//                               challenges.sort((a, b) => b.isCompleted ? 1 : -1);
//                               challenges.sort((a, b) => a.isClaimed ? 1 : -1);
//                               return ListView.builder(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemCount: challenges.length,
//                                 itemBuilder: (context, index) {
//                                   return ChallengeCard(
//                                     fem: fem,
//                                     hem: hem,
//                                     ffem: ffem,
//                                     challengeModel: challenges[index],
//                                   );
//                                 },
//                               );
//                             }
//                           }
//                           return Container();
//                         },
//                       ),
//                     ],
//                   ),
//                 )
//               ]),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
