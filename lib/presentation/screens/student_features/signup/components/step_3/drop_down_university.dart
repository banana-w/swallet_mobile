// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';

// class DropDownUniversity extends StatefulWidget {
//   final double hem;
//   final double fem;
//   final double ffem;
//   final String labelText;
//   final String hintText;
//   final FormFieldValidator<String> validator;
//   const DropDownUniversity(
//       {super.key,
//       required this.hem,
//       required this.fem,
//       required this.ffem,
//       required this.labelText,
//       required this.hintText,
//       required this.validator});

//   @override
//   State<DropDownUniversity> createState() => _DropDownUniversityState();
// }

// class _DropDownUniversityState extends State<DropDownUniversity> {
//   List<UniversityModel> universities = List.empty();

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 272 * widget.fem,
//       child: BlocConsumer<UniversityBloc, UniversityState>(
//         listener: (context, state) {
//           if (state is UniversityLoaded) {
//             universities = state.universities.toList();
//           }
//         },
//         builder: (context, state) {
//           if (state is UniversityLoading) {
//             return Center(
//                 child: Lottie.asset('assets/animations/loading-screen.json',
//                     width: 50 * widget.fem, height: 50 * widget.hem));
//           } else if (state is UniversityLoaded) {
//             universities = state.universities.toList();
//             return _dropDownUniversityLoaded();
//           }
//           return Center(
//             child: CircularProgressIndicator(
//               color: kPrimaryColor,
//             ),
//           );
//         },
//       ),
//     );
//   }

//   DropdownButtonFormField<String> _dropDownUniversityLoaded() {
//     return DropdownButtonFormField(
//       validator: widget.validator,
//       style: GoogleFonts.openSans(
//           textStyle: TextStyle(
//               color: Colors.black,
//               fontSize: 15 * widget.ffem,
//               fontWeight: FontWeight.w700)),
//       decoration: InputDecoration(
//         labelText: widget.labelText,
//         hintText: widget.hintText,
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         labelStyle: GoogleFonts.openSans(
//           textStyle: TextStyle(
//               color: kPrimaryColor,
//               fontSize: 15 * widget.ffem,
//               fontWeight: FontWeight.w900),
//         ),
//         hintStyle: GoogleFonts.openSans(
//             textStyle: TextStyle(
//                 color: kLowTextColor,
//                 fontSize: 15 * widget.ffem,
//                 fontWeight: FontWeight.w700)),
//         contentPadding: EdgeInsets.symmetric(
//             horizontal: 26 * widget.fem, vertical: 10 * widget.hem),
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(28 * widget.fem),
//             borderSide: BorderSide(
//                 width: 2, color: const Color.fromARGB(255, 220, 220, 220)),
//             gapPadding: 10),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(28 * widget.fem),
//             borderSide: BorderSide(
//                 width: 2, color: const Color.fromARGB(255, 220, 220, 220)),
//             gapPadding: 10),
//         errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(28 * widget.fem),
//             borderSide: BorderSide(
//                 width: 2, color: const Color.fromARGB(255, 220, 220, 220)),
//             gapPadding: 10),
//       ),
//       // value: null,
//       onChanged: (newValue) {
//         setState(() {
//           context
//               .read<CampusBloc>()
//               .add(LoadCampus(universityId: newValue.toString()));
//         });
//       },
//       items: universities.map((u) {
//         return DropdownMenuItem(
//           child: Text(u.universityName.toString()),
//           value: u.id,
//         );
//       }).toList(),
//     );
//   }
// }
