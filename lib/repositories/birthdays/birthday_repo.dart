import 'package:birth_daily/models/birthday/birthday_model.dart';

import 'package:birth_daily/services/birthday_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IBirthdayRepo {
  Future<List<BirthdayModel>> loadBirthdays();
}

class BirthdayRepo implements IBirthdayRepo {
  final BirthdayService _birthdayService = BirthdayService();
  @override
  Future<List<BirthdayModel>> loadBirthdays() async {
    final birthdayModel = await _birthdayService.getBirthdays();

    return birthdayModel;
  }

  Future<bool> addBirthday({
    required String name,
    required Timestamp date,
    required String imageURL,
    required bool isLovingOne,
  }) async {
    try {
      bool res = await _birthdayService.addBirthday(
          name: name, date: date, imageURL: imageURL, isLovingOne: isLovingOne);
      return res;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateBirthday({
    required String name,
    required Timestamp date,
    required String docId,
    required String imageURL,
    required bool isLovingOne,
  }) async {
    try {
      bool res = await _birthdayService.updateBirthday(
          name: name,
          date: date,
          docId: docId,
          imageURL: imageURL,
          isLovingOne: isLovingOne);
      return res;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteBirthday({required String docId}) async {
    try {
      bool res = await _birthdayService.deleteBirthday(docId: docId);
      return res;
    } catch (e) {
      return false;
    }
  }

  Future<BirthdayModel?> getBirthdayById({required String docId}) async {
    try {
      BirthdayModel res = await _birthdayService.getBirthdayById(docId: docId);
      return res;
    } catch (e) {
      return null;
    }
  }
}
