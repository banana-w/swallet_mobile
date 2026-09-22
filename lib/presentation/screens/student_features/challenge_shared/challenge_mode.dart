import 'package:swallet_mobile/data/models/student_features/challenge_model.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';

/// Phân biệt hai luồng thử thách dùng chung toàn bộ giao diện.
///
/// `challenge/` (thành tựu) và `challenge_daily/` (nhiệm vụ ngày) trước đây là
/// hai thư mục chép qua chép lại của nhau: 6 file tab và 6 file nút chỉ khác
/// nhau ở tên event và tên state. Giờ khác biệt đó gom hết vào đây.
enum ChallengeMode {
  /// Thành tựu — dùng `LoadChallenge` / `ClaimChallengeStudentId`.
  achievement,

  /// Nhiệm vụ ngày — dùng `LoadDailyChallenge` / `ClaimChallengeStudentIdDaily`.
  daily,
}

extension ChallengeModeX on ChallengeMode {
  /// Sự kiện tải lại danh sách thử thách.
  ChallengeEvent get reloadEvent => switch (this) {
    ChallengeMode.achievement => LoadChallenge(),
    ChallengeMode.daily => LoadDailyChallenge(),
  };

  /// Sự kiện nhận thưởng cho một thử thách.
  ChallengeEvent claimEvent({
    required String studentId,
    required String challengeId,
  }) => switch (this) {
    ChallengeMode.achievement => ClaimChallengeStudentId(
      studentId: studentId,
      challengeId: challengeId,
    ),
    ChallengeMode.daily => ClaimChallengeStudentIdDaily(
      studentId: studentId,
      challengeId: challengeId,
    ),
  };

  /// Đang gửi yêu cầu nhận thưởng.
  bool isClaiming(ChallengeState state) => switch (this) {
    ChallengeMode.achievement => state is ClaimAchieveLoading,
    ChallengeMode.daily => state is ClaimLoading,
  };

  /// Nhận thưởng vừa thành công.
  bool isClaimSuccess(ChallengeState state) => switch (this) {
    ChallengeMode.achievement =>
      state is ChallengesAchieveLoaded && state.isClaimed,
    ChallengeMode.daily => state is ChallengesLoaded && state.isClaimed,
  };

  /// Nội dung hiển thị khi tab "Đang thực hiện" rỗng.
  String get emptyInProcessText => switch (this) {
    ChallengeMode.achievement => 'Không có thành tựu nào!',
    ChallengeMode.daily => 'Không có thử thách',
  };
}

/// Danh sách thử thách kèm cờ vừa nhận thưởng, gộp hai state có cấu trúc
/// giống hệt nhau (`ChallengesLoaded` và `ChallengesAchieveLoaded`).
({List<ChallengeModel> items, bool isClaimed})? challengesOf(
  ChallengeState state,
) => switch (state) {
  ChallengesLoaded(:final challenge, :final isClaimed) => (
    items: challenge,
    isClaimed: isClaimed,
  ),
  ChallengesAchieveLoaded(:final challenge, :final isClaimed) => (
    items: challenge,
    isClaimed: isClaimed,
  ),
  _ => null,
};
