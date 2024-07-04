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
    List<dynamic> outputList = [];
    final today = DateTime.now();
    for (var i = 0; i < list.length; i++) {
      final DateTime date = list[i].data()['date'].toDate();
      if (date.isAfter(today)) {
        outputList.add(list[i].data());
      }
    }
    outputList.sort((a, b) {
      DateTime dateA = a['date'].toDate();
      DateTime dateB = b['date'].toDate();
      return dateA.compareTo(dateB);
    });
    return outputList;
  }

  static List<dynamic> getPastBirthdays({required List<dynamic> list}) {
    List<dynamic> outputList = [];
    final today = DateTime.now();
    for (var i = 0; i < list.length; i++) {
      final DateTime date = list[i].data()['date'].toDate();
      if (date.isBefore(today)) {
        outputList.add(list[i].data());
      }
    }
    outputList.sort((a, b) {
      DateTime dateA = a['date'].toDate();
      DateTime dateB = b['date'].toDate();
      return dateB.compareTo(dateA);
    });
    return outputList;
  }
}
