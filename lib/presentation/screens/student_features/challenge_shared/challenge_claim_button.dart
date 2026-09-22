import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/constants.dart';

/// Nút trạng thái của một thử thách.
///
/// Gộp ba file `in_process_button` / `is_completed_button` / `is_claimed_button`
/// — vốn được chép nguyên si sang cả `challenge/` lẫn `challenge_daily/`, tổng
/// cộng sáu file cho ba nút giống nhau tới từng khoảng trắng.
class ChallengeClaimButton extends StatelessWidget {
  /// Chưa đạt điều kiện: nút xám, bấm không có tác dụng.
  const ChallengeClaimButton.inProcess({
    super.key,
    required this.fem,
    required this.hem,
  }) : onPressed = null,
       _claimed = false;

  /// Đã hoàn thành, còn thưởng để nhận.
  const ChallengeClaimButton.claimable({
    super.key,
    required this.fem,
    required this.hem,
    required VoidCallback? onPressed,
  }) : onPressed = onPressed,
       _claimed = false;

  /// Đã nhận thưởng.
  const ChallengeClaimButton.claimed({
    super.key,
    required this.fem,
    required this.hem,
  }) : onPressed = null,
       _claimed = true;

  final double fem;
  final double hem;
  final VoidCallback? onPressed;
  final bool _claimed;

  @override
  Widget build(BuildContext context) {
    final label = _claimed ? 'Đã nhận' : 'Nhận';
    final textColor = _claimed ? kPrimaryColor : Colors.white;

    final Color background;
    if (_claimed) {
      background = Colors.white;
    } else if (onPressed == null) {
      background = kLowTextColor;
    } else {
      background = kPrimaryColor;
    }

    return Container(
      width: 85 * fem,
      height: (_claimed ? 33 : 32) * hem,
      margin: EdgeInsets.only(bottom: 15 * hem, left: 10 * fem),
      decoration: BoxDecoration(
        color: background,
        border: _claimed ? Border.all(color: kPrimaryColor) : null,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child:
            _claimed
                ? _label(label, textColor)
                : TextButton(
                  // Trước đây nút "Nhận" ở trạng thái chưa đủ điều kiện vẫn
                  // nhận `onPressed: (){}` nên vẫn loé hiệu ứng khi bấm.
                  onPressed: onPressed,
                  child: _label(label, textColor),
                ),
      ),
    );
  }

  Widget _label(String text, Color color) => Text(
    text,
    style: GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}
