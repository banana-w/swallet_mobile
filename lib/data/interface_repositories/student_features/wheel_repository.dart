abstract class SpinHistoryRepository {
  Future<int> getSpinCount(String studentId, DateTime date);
  Future<void> incrementSpinCount(String studentId, DateTime date);

  Future<int> getBonusSpins(String studentId, DateTime date);
  Future<void> incrementBonusSpins(String studentId, DateTime date);
}
