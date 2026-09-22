import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/presentation/widgets/shimmer_widget.dart';

import '../../../../config/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.studentModel});

  final StudentModel studentModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final hem = size.height / 812;
    final ffem = fem * 0.97;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20 * hem),
          Text(
            'Thông tin xác minh',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 18 * ffem,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 20 * hem),
          Container(
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: 15 * fem),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _ReadOnlyField(
                  fem: fem,
                  hem: hem,
                  ffem: ffem,
                  label: 'MÃ SỐ SINH VIÊN',
                  value: studentModel.code,
                ),
                const SizedBox(height: 20),
                _ReadOnlyField(
                  fem: fem,
                  hem: hem,
                  ffem: ffem,
                  label: 'EMAIL SINH VIÊN',
                  value: studentModel.studentEmail,
                ),
                const SizedBox(height: 20),
                Text(
                  'MẶT TRƯỚC THẺ SINH VIÊN',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 13 * ffem,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 10 * fem),
                Container(
                  width: 300 * fem,
                  height: 300 * fem,
                  decoration: BoxDecoration(
                    border: Border.all(color: klightPrimaryColor),
                    borderRadius: BorderRadius.circular(15 * fem),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x0c000000),
                        offset: Offset(0 * fem, 10 * fem),
                        blurRadius: 5 * fem,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Image.network(
                        studentModel.studentCardFront,
                        fit: BoxFit.fill,
                        // Ảnh thẻ sinh viên là ảnh chụp từ máy, thường vài
                        // nghìn pixel, trong khi khung chỉ rộng 300*fem.
                        cacheWidth:
                            (300 * fem * MediaQuery.devicePixelRatioOf(context))
                                .round(),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return ShimmerWidget.rectangular(height: 250 * hem);
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/ava_signup.png',
                            width: 100 * fem,
                            height: 100 * hem,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

/// Ô thông tin chỉ đọc của màn xác minh.
///
/// Hai ô mã số và email trước đây chép nguyên một khối `InputDecoration` dài
/// 70 dòng — ba viền giống hệt nhau, khác mỗi nhãn và giá trị.
class _ReadOnlyField extends StatelessWidget {
  const _ReadOnlyField({
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.label,
    required this.value,
  });

  final double fem;
  final double hem;
  final double ffem;
  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28 * fem),
      borderSide: const BorderSide(
        width: 2,
        color: Color.fromARGB(255, 220, 220, 220),
      ),
      gapPadding: 10,
    );

    return SizedBox(
      width: 272 * fem,
      child: TextFormField(
        readOnly: true,
        initialValue: value,
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 15 * ffem,
            fontWeight: FontWeight.bold,
          ),
        ),
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: kPrimaryColor,
              fontSize: 15 * ffem,
              fontWeight: FontWeight.w900,
            ),
          ),
          hintStyle: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: kLowTextColor,
              fontSize: 15 * ffem,
              fontWeight: FontWeight.w700,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 26 * fem,
            vertical: 10 * hem,
          ),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border,
        ),
      ),
    );
  }
}
