import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String title;
  final String body;
  final String payload;

  const NotificationModel({
    required this.title,
    required this.body,
    required this.payload,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      payload: json['payload'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'payload': payload, // Store payload as-is (already a JSON string)
    };
  }

  @override
  List<Object?> get props => [title, body, payload];
}
