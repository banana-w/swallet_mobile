import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
// import 'package:unibean_app/presentation/screens/student_features/welcome/welcome_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int pageIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  List<Map<String, String>> splashData = [
    {
      'image': 'assets/images/onboarding1.png',
      'title': 'Xin Chào!',
      'content':
          'Tìm kiếm những thông tin hữu ích,\n những hoạt động thú vị và những phần quà đặc biệt.',
      'button': 'Tiếp tục',
    },
    {
      'image': 'assets/images/onboarding2.png',
      'title': 'Nhận Bean Mọi Nơi!',
      'content':
          'Thu nhập các điểm thưởng\n và đổi lấy những phần quà hấp dẫn!.',
      'button': 'Tiếp tục',
    },
    {
      'image': 'assets/images/onboarding3.png',
      'title': 'Ưu Đãi Độc Quyền',
      'content':
          'Bạn sẽ tìm thấy những ưu đãi cũng như\n các phần quà đặc biệt chỉ có tại đây.',
      'button': 'Bắt đầu!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return PageView.builder(
      controller: pageController,
      onPageChanged: (value) {
        setState(() {
          pageIndex = value;
        });
      },
      itemCount: splashData.length,
      itemBuilder: (context, index) {
        if (pageIndex == 2) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(splashData[index]['image']!),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 530 * hem),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    splashData.length,
                    (index) => buildDot(fem, index: index),
                  ),
                ),
                SizedBox(height: 25 * hem),
                Text(
                  splashData[index]['title']!,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 20 * ffem,
                      fontWeight: FontWeight.w900,
                      height: 1.3625 * ffem / fem,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20 * hem),
                SizedBox(
                  height: 60 * hem,
                  child: Text(
                    splashData[index]['content']!,
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
                ),
                SizedBox(height: 20 * hem),
                TextButton(
                  onPressed: () {
                    // Navigator.pushNamedAndRemoveUntil(
                    //   context,
                    //   WelcomeScreen.routeName,
                    //   (Route<dynamic> route) => false,
                    // );
                  },
                  child: Container(
                    width: 270 * fem,
                    height: 45 * hem,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(23 * fem),
                    ),
                    child: Center(
                      child: Text(
                        splashData[index]['button']!,
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 17 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.3625 * ffem / fem,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              // color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(splashData[index]['image']!),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 520 * hem),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    splashData.length,
                    (index) => buildDot(fem, index: index),
                  ),
                ),
                SizedBox(height: 25 * hem),
                Text(
                  splashData[index]['title']!,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 20 * ffem,
                      fontWeight: FontWeight.w900,
                      height: 1.3625 * ffem / fem,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20 * hem),
                Container(
                  height: 60 * hem,
                  child: Text(
                    splashData[index]['content']!,
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
                ),
                SizedBox(height: 20 * hem),
                TextButton(
                  onPressed: () {
                    if (pageIndex == 0) {
                      setState(() {
                        pageIndex += 1;
                      });
                      pageController.animateToPage(
                        pageIndex,
                        duration: kAnimationDuration,
                        curve: Curves.linear,
                      );
                    } else if (pageIndex == 1) {
                      setState(() {
                        pageIndex += 1;
                      });
                      pageController.animateToPage(
                        pageIndex,
                        duration: kAnimationDuration,
                        curve: Curves.linear,
                      );
                    }
                  },
                  child: Container(
                    width: 270 * fem,
                    height: 45 * hem,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(23 * fem),
                    ),
                    child: Center(
                      child: Text(
                        splashData[index]['button']!,
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 17 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.3625 * ffem / fem,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigator.pushNamedAndRemoveUntil(
                    //   context,
                    //   WelcomeScreen.routeName,
                    //   (Route<dynamic> route) => false,
                    // );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20 * hem),
                    child: Text(
                      'Bỏ qua',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 13 * ffem,
                          fontWeight: FontWeight.w900,
                          height: 1.3625 * ffem / fem,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AnimatedContainer buildDot(double fem, {required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5 * fem),
      height: 6 * fem,
      width: 20 * fem,
      decoration: BoxDecoration(
        color: pageIndex == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
