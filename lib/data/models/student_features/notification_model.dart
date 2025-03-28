import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String title;
  final String body;
  final String payload;

  const NotificationModel(
      {required this.title, required this.body, required this.payload});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      payload: json['payload'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = this.title;
    data['body'] = this.body;
    data['payload'] = this.payload;
    return data;
  }

  @override
  List<Object?> get props => [title, body, payload];
}
