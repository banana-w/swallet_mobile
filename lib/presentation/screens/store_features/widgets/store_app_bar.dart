import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Thanh tiêu đề dùng chung cho các màn hình phía cửa hàng.
///
/// Tám màn hình trong `store_features` trước đây chép lại đúng một khối
/// `AppBar` như nhau — cùng ảnh nền, cùng tiêu đề canh giữa, cùng nút back và
/// nút về trang chủ — chỉ khác vài con số. Gom lại một chỗ để sửa một lần là
/// mọi màn hình cùng đổi.
class StoreAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StoreAppBar({
    super.key,
    required this.title,
    required this.fem,
    required this.ffem,
    required this.hem,
    this.toolbarHeight = 50,
    this.titleSize = 20,
    this.iconSize = 30,
    this.onBack,
    this.onHome,
  });

  final String title;
  final double fem;
  final double ffem;
  final double hem;

  /// Chiều cao thanh tiêu đề, tính theo hệ số thiết kế (sẽ nhân với [hem]).
  final double toolbarHeight;
  final double titleSize;
  final double iconSize;

  /// Bỏ trống thì không hiện nút back.
  final VoidCallback? onBack;

  /// Bỏ trống thì không hiện nút về trang chủ.
  final VoidCallback? onHome;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_splash.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      toolbarHeight: toolbarHeight * hem,
      centerTitle: true,
      leading:
          onBack == null
              ? null
              : InkWell(
                onTap: onBack,
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: iconSize * fem,
                ),
              ),
      title: Text(
        title,
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: titleSize * ffem,
            fontWeight: FontWeight.w900,
            height: 1.3625 * ffem / fem,
            color: Colors.white,
          ),
        ),
      ),
      actions:
          onHome == null
              ? null
              : [
                Padding(
                  padding: EdgeInsets.only(right: 20 * fem),
                  child: IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                      size: iconSize * fem,
                    ),
                    onPressed: onHome,
                  ),
                ),
              ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight * hem);
}
