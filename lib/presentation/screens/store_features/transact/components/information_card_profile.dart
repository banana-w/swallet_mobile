import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile/components/name_profile.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile/components/student_code_profile.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile/components/unitiversity_name_profile.dart';

class InformationCardProfile extends StatelessWidget {
  const InformationCardProfile({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.studentModel,
  });

  final double hem;
  final double fem;
  final double ffem;
  final StudentModel studentModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 324 * fem,
      padding: EdgeInsets.only(top: 15 * hem, bottom: 15 * hem),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15 * fem),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 25 * fem),

              //avatar
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  '${studentModel.studentCardFront}',
                  // 'assets/images/ava_signup.png',
                  width: 80 * fem,
                  height: 80 * hem,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/ava_signup.png',
                      width: 80 * fem,
                      height: 80 * hem,
                    );
                  },
                ),
              ),

              SizedBox(width: 20 * fem),

              SizedBox(
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Name
                    NameProfile(
                      fem: fem,
                      ffem: ffem,
                      hem: hem,
                      name: studentModel.fullName,
                    ),
                    //email
                    SizedBox(
                      width: 150 * fem,
                      child: Text(
                        '${studentModel.address}',
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 12 * ffem,
                            fontWeight: FontWeight.normal,
                            color: klowTextGrey,
                          ),
                        ),
                      ),
                    ),
                    //student code
                    StudentCodeProfile(
                      hem: hem,
                      fem: fem,
                      ffem: ffem,
                      studentCode: studentModel.code ?? 'student code',
                    ),
                    //university name
                    UniversityProfile(
                      fem: fem,
                      hem: hem,
                      ffem: ffem,
                      university: studentModel.campusId ?? 'university',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
