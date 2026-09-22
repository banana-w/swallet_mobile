import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';

import '../../../config/constants.dart';
import 'challenge_mode.dart';

/// Lớp phủ tiến trình khi đang nhận thưởng, kèm xử lý thành công và thất bại.
///
/// Trước đây mỗi tab tự mở hộp thoại tiến trình của riêng nó bằng
/// `showDialog(barrierDismissible: false)` + `PopScope(canPop: false)`, và
/// đóng lại bằng một `Navigator.of(context).pop()` trần. Cách đó có hai lỗi
/// nặng:
///
/// * `ChallengeFailed` **không được xử lý ở bất kỳ đâu**, mà bloc thì phát
///   state này mỗi khi nhận thưởng hỏng (mạng lỗi, server trả false, thử thách
///   đã nhận rồi). Hộp thoại không cho chạm ra ngoài, không cho bấm back —
///   nhận thưởng thất bại là app treo cứng, phải tắt đi mở lại;
/// * hai tab "Đang thực hiện" và "Nhận thưởng" cùng nghe một state, nên khi cả
///   hai còn sống (lúc vuốt qua lại giữa hai tab) sẽ mở hai hộp thoại chồng
///   nhau; còn `pop()` trần thì nếu hộp thoại chưa kịp mở sẽ đóng nhầm cả
///   trang bên dưới.
///
/// Giờ tiến trình nằm ngay trong cây widget (không phải route của Navigator)
/// và chỉ khai báo đúng một lần ở cấp màn hình.
class ChallengeClaimListener extends StatelessWidget {
  const ChallengeClaimListener({
    super.key,
    required this.mode,
    required this.child,
  });

  final ChallengeMode mode;
  final Widget child;

  void _onState(BuildContext context, ChallengeState state) {
    if (mode.isClaimSuccess(state)) {
      _showSnackBar(
        context,
        title: 'Nhận thưởng',
        message: 'Nhận thưởng thành công!',
        type: ContentType.success,
      );
      context.read<ChallengeBloc>().add(mode.reloadEvent);
    } else if (state is ChallengeFailed) {
      _showSnackBar(
        context,
        title: 'Thất bại',
        message: state.error,
        type: ContentType.failure,
      );
    }
  }

  void _showSnackBar(
    BuildContext context, {
    required String title,
    required String message,
    required ContentType type,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          duration: const Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: title,
            message: message,
            contentType: type,
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChallengeBloc, ChallengeState>(
      listenWhen:
          (previous, current) =>
              mode.isClaimSuccess(current) || current is ChallengeFailed,
      listener: _onState,
      buildWhen:
          (previous, current) =>
              mode.isClaiming(previous) != mode.isClaiming(current),
      builder: (context, state) {
        final isClaiming = mode.isClaiming(state);
        return Stack(
          fit: StackFit.expand,
          children: [
            child,
            if (isClaiming) ...[
              const ModalBarrier(dismissible: false, color: Colors.black38),
              const Center(
                child: Material(
                  color: Colors.transparent,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(color: kPrimaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
