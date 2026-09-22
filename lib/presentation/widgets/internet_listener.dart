import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/internet/internet_bloc.dart';

/// Theo dõi trạng thái mạng và hiển thị thông báo dùng chung cho mọi màn hình.
///
/// Trước đây mỗi màn hình tự chép lại khối `BlocListener<InternetBloc>` này,
/// kèm theo ba lỗi giống hệt nhau ở tất cả các bản sao:
///
/// * nút "Đồng ý" chỉ đóng hộp thoại khi đã có mạng trở lại, mà
///   `showCupertinoDialog` thì không cho chạm ra ngoài để tắt — mất mạng là
///   người dùng kẹt lại, không thao tác được gì nữa;
/// * chuỗi mất → có → mất mạng đẩy thêm một hộp thoại mới chồng lên cái cũ;
/// * nhiều màn hình xếp chồng thì mỗi màn mở một hộp thoại của riêng nó.
///
/// Hộp thoại ở đây dùng cờ static nên toàn app chỉ có đúng một cái, tự đóng
/// khi mạng trở lại, và luôn cho phép đóng bằng tay.
class InternetListener extends StatefulWidget {
  const InternetListener({super.key, required this.child});

  final Widget child;

  @override
  State<InternetListener> createState() => _InternetListenerState();
}

class _InternetListenerState extends State<InternetListener> {
  static bool _isDialogOpen = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      listener: _onInternetState,
      child: widget.child,
    );
  }

  void _onInternetState(BuildContext context, InternetState state) {
    if (state is Connected) {
      // clearSnackBars thay cho hideCurrentSnackBar: nhiều màn đang xếp chồng
      // sẽ cùng bắn thông báo này, dọn hàng đợi để chỉ còn đúng một cái.
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            elevation: 0,
            duration: const Duration(milliseconds: 2000),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Đã kết nối internet',
              message: 'Đã kết nối internet!',
              contentType: ContentType.success,
            ),
          ),
        );
      if (_isDialogOpen) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    } else if (state is NotConnected && !_isDialogOpen) {
      _showNoInternetDialog(context);
    }
  }

  Future<void> _showNoInternetDialog(BuildContext context) async {
    _isDialogOpen = true;
    try {
      await showCupertinoDialog<void>(
        context: context,
        builder:
            (dialogContext) => CupertinoAlertDialog(
              title: const Text('Không kết nối Internet'),
              content: const Text('Vui lòng kết nối Internet'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Đồng ý'),
                ),
              ],
            ),
      );
    } finally {
      _isDialogOpen = false;
    }
  }
}
