// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../../../../../../data/datasource/authen_local_datasource.dart';

// class OTPForm extends StatefulWidget {
//   const OTPForm({
//     super.key,
//     required this.fem,
//     required this.hem,
//     required this.defaultPinTheme,
//     required this.ffem,
//     required this.phoneNumber,
//   });

//   final double fem;
//   final double hem;
//   final PinTheme defaultPinTheme;
//   final double ffem;
//   final String phoneNumber;

//   @override
//   State<OTPForm> createState() => _OTPFormState();
// }

// class _OTPFormState extends State<OTPForm> {
//   final _formKey = GlobalKey<FormState>();
//   final pinController = TextEditingController();
//   final focusNode = FocusNode();
//   String? errorString;
//   late DateTime _endTime; // Add property to store end time

//   @override
//   void initState() {
//     super.initState();
//     // Initialize end time only once
//     _endTime = DateTime.now().add(Duration(seconds: 60));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authState = context.watch<AuthenticationBloc>().state;
//     var buttonWidget = (switch (authState) {
//       AuthenticationInitial() => _buildButton(),
//       // ignore: unused_local_variable
//       AuthenticationFailed(error: final error) => _buildButton(),
//       AuthenticationSuccess() => _buildButton(),
//       AuthenticationStoreSuccess() => _buildButton(),
//       AuthenticationInProcess() => _buildButtonLoading(),
//       AuthenticationInProcessByGmail() => _buildButton(),
//     });

//     buttonWidget = BlocListener<AuthenticationBloc, AuthenticationState>(
//       listener: (context, state) {
//         if (state is AuthenticationSuccess) {
//           // context.read<RoleAppBloc>().add(RoleAppStart());
//           Navigator.pushNamedAndRemoveUntil(context, SignUp9Screen.routeName,
//               (Route<dynamic> route) => false);
//         } else if (state is AuthenticationInProcess) {
//           showDialog<String>(
//               context: context,
//               builder: (BuildContext context) {
//                 Future.delayed(Duration(seconds: 20));
//                 return AlertDialog(
//                     content: Container(
//                         width: 250,
//                         height: 250,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Center(
//                                 child: CircularProgressIndicator(
//                                     color: kPrimaryColor)),
//                             Text(
//                               'Đang tạo tài khoản...',
//                               style: GoogleFonts.openSans(
//                                   textStyle: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.black)),
//                             )
//                           ],
//                         )));
//               });
//         }
//       },
//       child: buttonWidget,
//     );

//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           Container(
//             width: 350 * widget.fem,
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15 * widget.fem),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color(0x0c000000),
//                     offset: Offset(0 * widget.fem, 4 * widget.fem),
//                     blurRadius: 2.5 * widget.fem,
//                   )
//                 ]),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 22 * widget.hem,
//                 ),
//                 Container(
//                   child: Pinput(
//                     controller: pinController,
//                     focusNode: focusNode,
//                     length: 6,
//                     defaultPinTheme: widget.defaultPinTheme,
//                     focusedPinTheme: widget.defaultPinTheme,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Vui lòng nhập mã xác nhận';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 errorString != null
//                     ? Padding(
//                         padding: EdgeInsets.only(
//                           top: 5 * widget.hem,
//                           left: 5 * widget.fem,
//                         ),
//                         child: SizedBox(
//                           width: 270 * widget.fem,
//                           child: Text(
//                             errorString.toString(),
//                             style: GoogleFonts.openSans(
//                                 fontSize: 13 * widget.ffem,
//                                 fontWeight: FontWeight.normal,
//                                 height: 1.3625 * widget.ffem / widget.fem,
//                                 color: kErrorTextColor),
//                           ),
//                         ),
//                       )
//                     : SizedBox(
//                         height: 5 * widget.hem,
//                       ),
//                 SizedBox(
//                   height: 20 * widget.hem,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 20 * widget.hem,
//           ),
//           TimerCountdown(
//             spacerWidth: 5,
//             colonsTextStyle: GoogleFonts.openSans(
//                 textStyle: TextStyle(
//               fontSize: 13 * widget.ffem,
//               color: Colors.green,
//               fontWeight: FontWeight.w800,
//             )),
//             timeTextStyle: GoogleFonts.openSans(
//                 textStyle: TextStyle(
//               fontSize: 15 * widget.ffem,
//               color: Colors.green,
//               fontWeight: FontWeight.w800,
//             )),
//             format: CountDownTimerFormat.secondsOnly,
//             enableDescriptions: false,
//             endTime: _endTime,
//             onEnd: () {
//               Navigator.pop(context);
//             },
//           ),
//           SizedBox(
//             height: 10 * widget.hem,
//           ),
//           buttonWidget,
//           SizedBox(
//             height: 50 * widget.hem,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildButton() {
//     return BlocBuilder<VerificationCubit, VerificationState>(
//       builder: (context, state) {
//         return TextButton(
//           onPressed: () {
//             if (state is OTPVerificationFailed) {
//               setState(() {
//                 errorString = state.error;
//               });
//               if (_formKey.currentState!.validate()) {
//                 _submitForm(context, pinController);
//               }
//             } else {
//               if (_formKey.currentState!.validate()) {
//                 _submitForm(context, pinController);
//               }
//             }
//           },
//           child: Container(
//             width: 220 * widget.fem,
//             height: 45 * widget.hem,
//             decoration: BoxDecoration(
//                 color: kPrimaryColor,
//                 borderRadius: BorderRadius.circular(23 * widget.fem)),
//             child: BlocBuilder<VerificationCubit, VerificationState>(
//               builder: (context, state) {
//                 if (state is VerificationLoading) {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                     ),
//                   );
//                 }
//                 return Center(
//                   child: Text(
//                     'Tiếp tục',
//                     style: GoogleFonts.openSans(
//                         textStyle: TextStyle(
//                             fontSize: 17 * widget.ffem,
//                             fontWeight: FontWeight.w600,
//                             height: 1.3625 * widget.ffem / widget.fem,
//                             color: Colors.white)),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildButtonLoading() {
//     return BlocBuilder<VerificationCubit, VerificationState>(
//       builder: (context, state) {
//         return TextButton(
//           onPressed: () {
//             if (state is OTPVerificationFailed) {
//               setState(() {
//                 errorString = state.error;
//               });
//               if (_formKey.currentState!.validate()) {
//                 _submitForm(context, pinController);
//               }
//             } else {
//               if (_formKey.currentState!.validate()) {
//                 _submitForm(context, pinController);
//               }
//             }
//           },
//           child: Container(
//             width: 300 * widget.fem,
//             height: 45 * widget.hem,
//             decoration: BoxDecoration(
//                 color: kPrimaryColor,
//                 borderRadius: BorderRadius.circular(23 * widget.fem)),
//             child: BlocBuilder<VerificationCubit, VerificationState>(
//               builder: (context, state) {
//                 if (state is VerificationLoading) {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                     ),
//                   );
//                 }
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// void _submitForm(BuildContext context, pinController) async {
//   final authenModel = await AuthenLocalDataSource.getVerifyAuthen();
//   if (authenModel == null) {
//     context
//         .read<VerificationCubit>()
//         .verifyOTP(pinController.text)
//         .then((value) async {
//       if (value!) {
//         final createAuthenModel = await AuthenLocalDataSource.getCreateAuthen();
//         context
//             .read<AuthenticationBloc>()
//             .add(RegisterAccount(createAuthenModel: createAuthenModel!));
//       } else {}
//     });
//   } else {
//     context
//         .read<VerificationCubit>()
//         .verifyOTP(pinController.text)
//         .then((value) async {
//       if (value!) {
//         final verifyAuthenModel = await AuthenLocalDataSource.getVerifyAuthen();
//         context
//             .read<AuthenticationBloc>()
//             .add(VerifyAccount(verifyAuthenModel: verifyAuthenModel!));
//       } else {}
//     });
//   }
// }
