import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import model QRCodeHistory
import 'package:swallet_mobile/data/models/lecture_features/qr_code_history.dart';

import '../../../../config/constants.dart';
import '../../../../widgets/shimmer_widget.dart';

class QRCodeHistoryListCard extends StatelessWidget {
  const QRCodeHistoryListCard({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.qrCodeHistory,
  });

  final double fem;
  final double hem;
  final double ffem;
  final QRCodeHistory qrCodeHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 15 * fem,
        right: 15 * fem,
        bottom: 15 * hem,
      ),
      width: double.infinity,
      height: 130 * hem,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15 * fem),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF757575).withOpacity(0.3),
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: const Offset(5.0, 5.0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hình ảnh mã QR
          Container(
            margin: EdgeInsets.only(
              top: 5 * hem,
              left: 5 * fem,
              bottom: 5 * hem,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10 * fem),
              child: Container(
                width: 120 * fem,
                height: 120 * hem,
                child: Image.network(
                  qrCodeHistory.qrCodeImageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return ShimmerWidget.rectangular(height: 120 * hem);
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/image-404.jpg');
                  },
                ),
              ),
            ),
          ),
          SizedBox(width: 10 * fem),
          // Thông tin của QRCodeHistory
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5 * hem),
                  child: Text(
                    'Số điểm: ${qrCodeHistory.points}',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 14 * ffem,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5 * hem),
                Text(
                  'Thời gian tạo:',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 13 * ffem,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Text(
                  changeFormatDate(qrCodeHistory.createdAt),
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 12 * ffem,
                      color: klowTextGrey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: 5 * hem),
                Text(
                  'Hết hạn:',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 13 * ffem,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Text(
                  changeFormatDate(qrCodeHistory.expirationTime),
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 12 * ffem,
                      color: klowTextGrey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Hàm định dạng ngày (tương tự như changeFormateDate trong code gốc)
  String changeFormatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
}
