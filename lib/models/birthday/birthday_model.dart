import 'package:cloud_firestore/cloud_firestore.dart';

class BirthdayModel {
  final String name;
  final Timestamp dateTime;
  final bool isLovingOne;
  final String? id;
  final String imageURL;

  BirthdayModel(
      {required this.dateTime,
      required this.name,
      this.id,
      required this.imageURL,
      required this.isLovingOne});

  BirthdayModel.fromJson(Map<String, dynamic> json, String id)
      : this(
            name: json['name']! as String? ?? "Unknown",
            dateTime: json['date']! as Timestamp? ?? Timestamp.now(),
            id: id,
            isLovingOne: json['isLovingOne'] ?? false,
            imageURL: json['imageURL'] as String? ?? "assets/avatars/2.png");

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'age': dateTime,
      'isLovingOne': isLovingOne,
      'imageURL': imageURL
    };
  }
}
