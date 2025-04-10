import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/student_features/challenge_model.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';

import '../../../../config/constants.dart';
import 'in_process/in_process_button.dart';
import 'is_claimed/is_claimed_button.dart';
import 'is_completed/is_completed_button.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard(
      {super.key,
      required this.fem,
      required this.hem,
      required this.ffem,
      required this.challengeModel});

  final double fem;
  final double hem;
  final double ffem;
  final ChallengeModel challengeModel;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('###,000');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          constraints:
              BoxConstraints(maxWidth: 330 * fem, maxHeight: double.infinity),
          margin:
              EdgeInsets.only(top: 15 * hem, left: 15 * fem, right: 15 * fem),
          padding: EdgeInsets.only(left: 20 * fem, right: 15 * fem),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15 * fem),
            border: Border.all(color: kPrimaryColor),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15 * hem,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    // borderRadius: BorderRadius.circular(10 * fem),
                    child: SizedBox(
                      width: 30 * fem,
                      height: 30 * hem,
                      child: Image.network(
                        challengeModel.challengeImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.error_outlined,
                            size: 30 * fem,
                            color: kPrimaryColor,
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 250 * fem,
                    padding: EdgeInsets.only(left: 10 * fem),
                    child: Text(
                      challengeModel.description,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.openSans(
                        fontSize: 16 * ffem,
                        height: 1.3625 * ffem / fem,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20 * hem,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tiến độ',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.openSans(
                      fontSize: 15 * ffem,
                      height: 1.3625 * ffem / fem,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10 * fem),
                    child: RichText(
                      text: TextSpan(
                          text: '${challengeModel.current.toStringAsFixed(0)}',
                          style: GoogleFonts.openSans(
                            fontSize: 17 * ffem,
                            height: 1.3625 * ffem / fem,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  '/${challengeModel.condition.toStringAsFixed(0)}',
                              style: GoogleFonts.openSans(
                                fontSize: 17 * ffem,
                                height: 1.3625 * ffem / fem,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ]),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5 * hem,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phần thưởng',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.openSans(
                      fontSize: 15 * ffem,
                      height: 1.3625 * ffem / fem,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '+ ${formatter.format(challengeModel.amount)}',
                        style: GoogleFonts.openSans(
                          color: kPrimaryColor,
                          fontSize: 17 * ffem,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5 * fem,
                      ),
                      SvgPicture.asset(
                        'assets/icons/coin.svg',
                        width: 20 * fem,
                        height: 25 * fem,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5 * hem,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 190 * fem,
                  ),
                  _checkCondition(challengeModel, fem, hem, context)
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

Widget _checkCondition(
    ChallengeModel challenge, fem, hem, BuildContext context) {
  if (challenge.isCompleted && challenge.isClaimed) {
    return IsClaimedButton(fem: fem, hem: hem);
  } else if (challenge.isCompleted && challenge.isClaimed == false) {
    return IsCompletedButton(
      fem: fem,
      hem: hem,
      onPressed: () async {
        final studentId = await AuthenLocalDataSource.getStudentId();
        context.read<ChallengeBloc>().add(ClaimChallengeStudentId(
            studentId: studentId!, challengeId: challenge.id));
      },
    );
  }
  return InProcessButton(fem: fem, hem: hem);
}
