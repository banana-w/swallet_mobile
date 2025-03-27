import 'package:equatable/equatable.dart';

class Campaign extends Equatable {
  final String id;
  final String brandId;
  final String brandName;
  final String brandAcronym;
  final String typeId;
  final String typeName;
  final String campaignName;
  final String image;
  final String imageName;
  final String file;
  final String fileName;
  final String condition;
  final String link;
  final String startOn;
  final String endOn;
  final int duration;
  final double totalIncome;
  final double totalSpending;
  final String dateCreated;
  final String dateUpdated;
  final String description;
  final int currentStateId;
  final String currentState;
  final String currentStateName;
  final bool status;

  Campaign(
      {required this.id,
      required this.brandId,
      required this.brandName,
      required this.brandAcronym,
      required this.typeId,
      required this.typeName,
      required this.campaignName,
      required this.image,
      required this.imageName,
      required this.file,
      required this.fileName,
      required this.condition,
      required this.link,
      required this.startOn,
      required this.endOn,
      required this.duration,
      required this.totalIncome,
      required this.totalSpending,
      required this.dateCreated,
      required this.dateUpdated,
      required this.description,
      required this.currentStateId,
      required this.currentState,
      required this.currentStateName,
      required this.status});
  @override
  List<Object> get props => [
        this.id,
        this.brandId,
        this.brandName,
        this.brandAcronym,
        this.typeId,
        this.typeName,
        this.campaignName,
        this.image,
        this.imageName,
        this.file,
        this.fileName,
        this.condition,
        this.link,
        this.startOn,
        this.endOn,
        this.duration,
        this.totalIncome,
        this.totalSpending,
        this.dateCreated,
        this.dateUpdated,
        this.description,
        this.currentStateId,
        this.currentState,
        this.currentStateName,
        this.status
      ];
}
