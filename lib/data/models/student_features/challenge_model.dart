
import 'package:swallet_mobile/domain/entities/student_features/challenge.dart';

class ChallengeModel extends Challenge {
  const ChallengeModel(
      {required super.id,
      required super.challengeId,
      required super.challengeType,
      required super.challengeTypeName,
      required super.challengeName,
      required super.challengeImage,
      required super.studentId,
      required super.studentName,
      required super.amount,
      required super.current,
      required super.condition,
      required super.isCompleted,
      required super.isClaimed,
      required super.dateCreated,
      required super.dateUpdated,
      required super.description,
      required super.status});

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    return ChallengeModel(
      id: json['id'],
      challengeId: json['challengeId'],
      challengeType: json['challengeType'],
      challengeTypeName: json['challengeTypeName'],
      challengeName: json['challengeName'],
      challengeImage: json['challengeImage'],
      studentId: json['studentId'],
      studentName: json['studentName'],
      amount: json['amount'],
      current: json['current'],
      condition: json['condition'],
      isCompleted: json['isCompleted'],
      isClaimed: json['isClaimed'],
      dateCreated: json['dateCreated'],
      dateUpdated: json['dateUpdated'] ?? '',
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['challengeId'] = challengeId;
    data['challengeType'] = challengeType;
    data['challengeTypeName'] = challengeTypeName;
    data['challengeName'] = challengeName;
    data['challengeImage'] = challengeImage;
    data['studentId'] = studentId;
    data['studentName'] = studentName;
    data['amount'] = amount;
    data['current'] = current;
    data['condition'] = condition;
    data['isCompleted'] = isCompleted;
    data['isClaimed'] = isClaimed;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['description'] = description;
    data['status'] = status;
    return data;
  }

  ChallengeModel copyWith({
    String? id,
    String? challengeId,
    String? challengeType,
    String? challengeTypeName,
    String? challengeName,
    String? challengeImage,
    String? studentId,
    String? studentName,
    double? amount,
    int? current,
    double? condition,
    bool? isCompleted,
    bool? isClaimed,
    String? dateCreated,
    String? dateUpdated,
    String? description,
    bool? state,
    bool? status,
  }) {
    return ChallengeModel(
        id: id ?? this.id,
        challengeId: challengeId ?? this.challengeId,
        challengeType: challengeType ?? this.challengeType,
        challengeTypeName: challengeTypeName ?? this.challengeTypeName,
        challengeName: challengeName ?? this.challengeName,
        challengeImage: challengeImage ?? this.challengeImage,
        studentId: studentId ?? this.studentId,
        studentName: studentName ?? this.studentName,
        amount: amount ?? this.amount,
        current: current ?? this.current,
        condition: condition ?? this.condition,
        isCompleted: isCompleted ?? this.isCompleted,
        isClaimed: isClaimed ?? this.isClaimed,
        dateCreated: dateCreated ?? this.dateCreated,
        dateUpdated: dateUpdated ?? this.dateUpdated,
        description: description ?? this.description,
        status: status ?? this.status);
  }
}
