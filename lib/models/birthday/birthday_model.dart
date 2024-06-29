import 'package:cloud_firestore/cloud_firestore.dart';

class BirthdayModel {
  final String name;
  final Timestamp dateTime;

  BirthdayModel({required this.dateTime, required this.name, required uid});

  BirthdayModel.fromJson(Map<String, dynamic> json)
      : this(
            name: json['name']! as String,
            dateTime: json['date']! as Timestamp,
            uid: json['uid']);

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'age': dateTime,
    };
  }
}
