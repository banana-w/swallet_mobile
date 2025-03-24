// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ButtonSignUp8 extends StatelessWidget {
//   const ButtonSignUp8(
//       {super.key, required this.widget, required this.onPressed});

//   final OTPForm widget;
//   final VoidCallback onPressed;
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: onPressed,
//       child: Container(
//         width: 300 * widget.fem,
//         height: 45 * widget.hem,
//         decoration: BoxDecoration(
//             color: kPrimaryColor,
//             borderRadius: BorderRadius.circular(23 * widget.fem)),
//         child: BlocBuilder<VerificationCubit, VerificationState>(
//           builder: (context, state) {
//             if (state is VerificationLoading) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                 ),
//               );
//             }
//             return Center(
//               child: Text(
//                 'Tiếp tục',
//                 style: GoogleFonts.openSans(
//                     textStyle: TextStyle(
//                         fontSize: 17 * widget.ffem,
//                         fontWeight: FontWeight.w600,
//                         height: 1.3625 * widget.ffem / widget.fem,
//                         color: Colors.white)),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
