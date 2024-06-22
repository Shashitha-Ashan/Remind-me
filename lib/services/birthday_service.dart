import 'dart:ui';

import 'package:birth_daily/models/birthday/birthday_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BirthdayService {
  late BirthdayModel birthdayModel;
  final birthdays = FirebaseFirestore.instance.collection('birthdays');

  Future<BirthdayModel> getBirthdays() async {
    await Future.delayed(const Duration(seconds: 3));
    birthdayModel = BirthdayModel(dateTime: DateTime.now(), name: "Ashan");
    return birthdayModel;
  }
}
