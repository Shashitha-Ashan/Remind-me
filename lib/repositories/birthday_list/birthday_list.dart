import 'package:birth_daily/helpers/date_time_helper.dart';
import 'package:birth_daily/models/birthday/birthday_model.dart';
import 'package:birth_daily/services/birthday_service.dart';

abstract class IBirthdayListRepo {
  List<BirthdayModel> getSelectedDateBirthdayList(
      {required DateTime selectedDate, required List<dynamic> list});
  Future<List<BirthdayModel>> getAllBirthdays();
  List<BirthdayModel> getTodayBirthdayList({required List<dynamic> list});
  List<BirthdayModel> getUpcomingBirthdayList({required List<dynamic> list});
  List<BirthdayModel> getPastBirthdayList({required List<dynamic> list});
}

class BirthdayListRepo extends IBirthdayListRepo {
  @override
  List<BirthdayModel> getPastBirthdayList({required List<dynamic> list}) {
    return DateTimeHelper.getPastBirthdays(list: list);
  }

  @override
  List<BirthdayModel> getSelectedDateBirthdayList(
      {required DateTime selectedDate, required List<dynamic> list}) {
    return DateTimeHelper.getSelectedDateBirthdays(
        selectedDate: selectedDate, list: list);
  }

  @override
  List<BirthdayModel> getTodayBirthdayList({required List<dynamic> list}) {
    return DateTimeHelper.getTodayBirthdays(list: list);
  }

  @override
  List<BirthdayModel> getUpcomingBirthdayList({required List<dynamic> list}) {
    return DateTimeHelper.getUpcomingBirthdays(list: list);
  }

  @override
  Future<List<BirthdayModel>> getAllBirthdays() async {
    return BirthdayService().getBirthdays();
  }
}
