import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/student_features/challenge_model.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/location_checkin/location_screen.dart';

import '../../../config/constants.dart';
import 'challenge_claim_button.dart';
import 'challenge_mode.dart';

/// Thẻ hiển thị một thử thách kèm tiến độ, phần thưởng và nút nhận.
class ChallengeCard extends StatelessWidget {
  const ChallengeCard({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.challengeModel,
    required this.mode,
    required this.isClaiming,
  });

  /// Định dạng số chỉ dựng một lần thay vì mỗi lần `build()` một đối tượng.
  static final NumberFormat _amountFormat = NumberFormat('###,000');

  final double fem;
  final double hem;
  final double ffem;
  final ChallengeModel challengeModel;
  final ChallengeMode mode;

  /// Đang có một yêu cầu nhận thưởng chạy dở; khoá nút để không gửi trùng.
  final bool isClaiming;

  Future<void> _claim(BuildContext context) async {
    final student = await AuthenLocalDataSource.getStudent();
    if (!context.mounted) return;
    if (student == null) {
      // Trước đây dùng `student!.id`: hết phiên đăng nhập là văng lỗi null.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Không tìm thấy thông tin sinh viên, vui lòng đăng nhập lại',
          ),
        ),
      );
      return;
    }
    context.read<ChallengeBloc>().add(
      mode.claimEvent(studentId: student.id, challengeId: challengeModel.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 330 * fem),
      margin: EdgeInsets.only(top: 15 * hem, left: 15 * fem, right: 15 * fem),
      padding: EdgeInsets.only(left: 20 * fem, right: 15 * fem),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15 * fem),
        border: Border.all(color: kPrimaryColor),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15 * hem),
          Row(
            crossAxisAlignment:
                mode == ChallengeMode.daily
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 30 * fem,
                height: 30 * hem,
                child: Image.network(
                  challengeModel.challengeImage,
                  fit: BoxFit.cover,
                  // Khung ảnh chỉ 30px; không có cacheWidth thì ảnh gốc được
                  // giải mã ở nguyên kích thước rồi mới thu nhỏ.
                  cacheWidth:
                      (30 * fem * MediaQuery.devicePixelRatioOf(context))
                          .round(),
                  errorBuilder:
                      (context, error, stackTrace) => Icon(
                        Icons.error_outlined,
                        size: 30 * fem,
                        color: kPrimaryColor,
                      ),
                ),
              ),
              Container(
                width: 250 * fem,
                padding: EdgeInsets.only(left: 10 * fem),
                child:
                    mode == ChallengeMode.daily
                        ? _dailyTitle(context)
                        : _achievementTitle(),
              ),
            ],
          ),
          SizedBox(height: 20 * hem),
          _detailRow(
            'Tiến độ',
            RichText(
              text: TextSpan(
                text: challengeModel.current.toStringAsFixed(0),
                style: _valueStyle(kPrimaryColor),
                children: [
                  TextSpan(
                    text: '/${challengeModel.condition.toStringAsFixed(0)}',
                    style: _valueStyle(Colors.black),
                  ),
                ],
              ),
            ),
            trailingPadding: 10 * fem,
          ),
          SizedBox(height: 5 * hem),
          _detailRow(
            'Phần thưởng',
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  mode == ChallengeMode.daily
                      ? '+ ${challengeModel.amount.toInt()}'
                      : '+ ${_amountFormat.format(challengeModel.amount)}',
                  style: GoogleFonts.openSans(
                    color: kPrimaryColor,
                    fontSize: 17 * ffem,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5 * fem),
                SvgPicture.asset(
                  'assets/icons/coin.svg',
                  width: 20 * fem,
                  height: 25 * fem,
                ),
              ],
            ),
          ),
          SizedBox(height: 5 * hem),
          Row(children: [SizedBox(width: 190 * fem), _actionButton(context)]),
        ],
      ),
    );
  }

  Widget _achievementTitle() => Text(
    challengeModel.description,
    textAlign: TextAlign.justify,
    style: GoogleFonts.openSans(
      fontSize: 16 * ffem,
      height: 1.3625 * ffem / fem,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );

  Widget _dailyTitle(BuildContext context) {
    final isCheckIn = challengeModel.category == 'Check-in';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          challengeModel.challengeName,
          textAlign: TextAlign.justify,
          style: GoogleFonts.openSans(
            fontSize: 16 * ffem,
            height: 1.3625 * ffem / fem,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4 * hem), // khoảng cách nhỏ giữa 2 dòng
        GestureDetector(
          onTap:
              isCheckIn
                  ? () =>
                      Navigator.pushNamed(context, LocationListScreen.routeName)
                  : null,
          child: Text(
            challengeModel.description,
            textAlign: TextAlign.justify,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
              fontSize: 12 * ffem,
              height: 1.3,
              color: Colors.grey[700],
              decoration: isCheckIn ? TextDecoration.underline : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _actionButton(BuildContext context) {
    if (challengeModel.isClaimed) {
      return ChallengeClaimButton.claimed(fem: fem, hem: hem);
    }
    if (challengeModel.isCompleted) {
      return ChallengeClaimButton.claimable(
        fem: fem,
        hem: hem,
        // Trước đây không có gì chặn bấm liên tục: mỗi lần chạm là một yêu
        // cầu nhận thưởng nữa được gửi đi.
        onPressed: isClaiming ? null : () => _claim(context),
      );
    }
    return ChallengeClaimButton.inProcess(fem: fem, hem: hem);
  }

  Widget _detailRow(String label, Widget value, {double trailingPadding = 0}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.justify,
          style: GoogleFonts.openSans(
            fontSize: 15 * ffem,
            height: 1.3625 * ffem / fem,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        Padding(padding: EdgeInsets.only(right: trailingPadding), child: value),
      ],
    );
  }

  TextStyle _valueStyle(Color color) => GoogleFonts.openSans(
    fontSize: 17 * ffem,
    height: 1.3625 * ffem / fem,
    fontWeight: FontWeight.bold,
    color: color,
  );
}
