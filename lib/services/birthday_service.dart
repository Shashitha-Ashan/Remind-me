import 'package:birth_daily/models/birthday/birthday_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BirthdayService {
  late BirthdayModel birthdayModel;
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection("birthdays");

  Future<List<BirthdayModel>> getBirthdays() async {
    final bdsList = await _collection.where('uid', isEqualTo: user?.uid).get();

    final birthdaysList =
        bdsList.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    final birthdayModelList =
        birthdaysList.map((val) => BirthdayModel.fromJson(val)).toList();
    return birthdayModelList;
  }

  Future<bool> addBirthday(
      {required String name, required DateTime date}) async {
    if (user != null) {
      await _collection.add({'date': date, 'name': name, 'uid': user?.uid});
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateBirthday(
      {required String name,
      required DateTime date,
      required String docId}) async {
    if (user != null) {
      await _collection
          .doc(docId)
          .update({'date': date, 'name': name, 'uid': user?.uid});
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteBirthday({required String docId}) async {
    if (user != null) {
      await _collection.doc(docId).delete();
      return true;
    } else {
      return false;
    }
  }
}
