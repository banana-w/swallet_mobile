import 'package:equatable/equatable.dart';

class Challenge extends Equatable {
  final String id;
  final String challengeId;
  final String challengeType;
  final String challengeTypeName;
  final String challengeName;
  final String challengeImage;
  final String studentId;
  final String studentName;
  final double amount;
  final int current;
  final double condition;
  final bool isCompleted;
  final bool isClaimed;
  final String dateCreated;
  final String dateUpdated;
  final String description;
  final bool status;
  final String category;

  const Challenge(
      {required this.id,
      required this.challengeId,
      required this.challengeType,
      required this.challengeTypeName,
      required this.challengeName,
      required this.challengeImage,
      required this.studentId,
      required this.studentName,
      required this.amount,
      required this.current,
      required this.condition,
      required this.isCompleted,
      required this.isClaimed,
      required this.dateCreated,
      required this.dateUpdated,
      required this.description,
      required this.status,
      required this.category});

  @override
  List<Object> get props => [
        id,
        challengeId,
        challengeType,
        challengeTypeName,
        challengeName,
        challengeImage,
        studentId,
        studentName,
        amount,
        current,
        condition,
        isCompleted,
        isClaimed,
        dateCreated,
        dateUpdated,
        description,
        status
      ];
}
