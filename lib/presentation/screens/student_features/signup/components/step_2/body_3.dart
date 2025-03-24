import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_2/form_3.dart';

class Body3 extends StatefulWidget {
  Body3({super.key});

  @override
  State<Body3> createState() => _Body3State();
}

class _Body3State extends State<Body3> {
  final dobController = TextEditingController();

  @override
  void dispose() {
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/bg_signup_3.png'),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 400 * hem),
              Text(
                'Các thông tin khác về bạn',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 20 * ffem,
                    fontWeight: FontWeight.w900,
                    height: 1.3625 * ffem / fem,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10 * hem),
              Text(
                'Chúng mình mong muốn tìm hiểu thêm\n về bạn để cung cấp và giới thiệu cho bạn\n các hoạt động phù hợp.',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 15 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.3625 * ffem / fem,
                    color: kLowTextColor,
                  ),
                ),
              ),
              SizedBox(height: 18 * hem),
              FormBody3(
                fem: fem,
                hem: hem,
                ffem: ffem,
                dobController: dobController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
