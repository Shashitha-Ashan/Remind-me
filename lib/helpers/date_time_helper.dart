import 'package:birth_daily/models/birthday/birthday_model.dart';

class DateTimeHelper {
  static List<BirthdayModel> getSelectedDateBirthdays(
      {required DateTime selectedDate, required List<dynamic> list}) {
    List<BirthdayModel> outputlList = [];

    for (var i = 0; i < list.length; i++) {
      final DateTime date = list[i].data()['date'].toDate();
      if (date.month == selectedDate.month && date.day == selectedDate.day) {
        outputlList.add(BirthdayModel.fromJson(list[i].data(), list[i].id));
      }
    }
    return outputlList;
  }

  static List<BirthdayModel> getTodayBirthdays({required List<dynamic> list}) {
    List<BirthdayModel> outputlList = [];
    final today = DateTime.now();
    for (var i = 0; i < list.length; i++) {
      final DateTime date = list[i].data()['date'].toDate();
      if (date.month == today.month && date.day == today.day) {
        outputlList.add(BirthdayModel.fromJson(list[i].data(), list[i].id));
      }
    }

    return outputlList;
  }

  static List<BirthdayModel> getUpcomingBirthdays(
      {required List<dynamic> list}) {
    List<BirthdayModel> outputList = [];
    final today = DateTime.now();
    for (var i = 0; i < list.length; i++) {
      final DateTime date = list[i].data()['date'].toDate();
      if (date.isAfter(today)) {
        outputList.add(BirthdayModel.fromJson(list[i].data(), list[i].id));
      }
    }
    outputList.sort((a, b) {
      DateTime dateA = a.dateTime!.toDate();
      DateTime dateB = b.dateTime!.toDate();
      return dateA.compareTo(dateB);
    });
    return outputList;
  }

  static List<BirthdayModel> getPastBirthdays({required List<dynamic> list}) {
    List<BirthdayModel> outputList = [];
    final today = DateTime.now();
    for (var i = 0; i < list.length; i++) {
      final DateTime date = list[i].data()['date'].toDate();
      if (date.isBefore(today)) {
        outputList.add(BirthdayModel.fromJson(list[i].data(), list[i].id));
      }
    }
    outputList.sort((a, b) {
      DateTime dateA = a.dateTime!.toDate();
      DateTime dateB = b.dateTime!.toDate();
      return dateB.compareTo(dateA);
    });
    return outputList;
  }
}
