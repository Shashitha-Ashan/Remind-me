import 'package:birth_daily/models/birthday/birthday_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BirthdayDocument {
  final String docId;
  final Map<String, dynamic> data;

  BirthdayDocument({required this.docId, required this.data});
}

class BirthdayService {
  late BirthdayModel birthdayModel;
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection("birthdays");

  Future<List<BirthdayModel>> getBirthdays() async {
    final bdsList = await _collection.where('uid', isEqualTo: user?.uid).get();

    final List<BirthdayDocument> birthdaysList = bdsList.docs
        .map((doc) {
          BirthdayDocument(
              data: doc.data() as Map<String, dynamic>, docId: doc.id);
        })
        .cast<BirthdayDocument>()
        .toList();

    final birthdayModelList = birthdaysList
        .map((val) => BirthdayModel.fromJson(val.data, val.docId))
        .toList();
    return birthdayModelList;
  }

  Future<bool> addBirthday({
    required String name,
    required Timestamp date,
    required String imageURL,
    required bool isLovingOne,
  }) async {
    if (user != null) {
      await _collection.add({
        'date': date,
        'name': name,
        'uid': user?.uid,
        'isLovingOne': isLovingOne,
        'imageURL': imageURL
      });
      return true;
    } else {
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
    if (user != null) {
      await _collection.doc(docId).update({
        'date': date,
        'name': name,
        'uid': user?.uid,
        'isLovingOne': isLovingOne,
        'imageURL': imageURL
      });
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

  Future<BirthdayModel> getBirthdayById({required String docId}) async {
    final doc = await _collection.doc(docId).get();
    final Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return BirthdayModel.fromJson(json, doc.id);
  }
}
