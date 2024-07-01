import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DateTimeHelper {
  static List<dynamic> getSelectedDateBirthdays(
      {required DateTime selectedDate, required List<dynamic> list}) {
    List<dynamic> outputlList = [];

    for (var i = 0; i < list.length; i++) {
      final DateTime date = list[i].data()['date'].toDate();
      if (date.month == selectedDate.month && date.day == selectedDate.day) {
        outputlList.add(list[i].data());
      }
    }
    return outputlList;
  }

  static List<dynamic> getTodayBirthdays({required List<dynamic> list}) {
    List<dynamic> outputlList = [];
    final today = DateTime.now();
    for (var i = 0; i < list.length; i++) {
      final DateTime date = list[i].data()['date'].toDate();
      if (date.month == today.month && date.day == today.day) {
        outputlList.add(list[i].data());
      }
    }

    return outputlList;
  }

  static List<dynamic> getUpcomingBirthdays({required List<dynamic> list}) {
    List<dynamic> outputlList = [];
    final today = DateTime.now();
    for (var i = 0; i < list.length; i++) {
      final DateTime date = list[i].data()['date'].toDate();
      if (date.isAfter(today)) {
        outputlList.add(list[i].data());
      }
    }
    print(outputlList.length);
    return outputlList;
  }
}
