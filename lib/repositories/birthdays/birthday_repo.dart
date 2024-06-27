import 'package:birth_daily/models/birthday/birthday_model.dart';

import 'package:birth_daily/services/birthday_service.dart';

abstract class IBirthdayRepo {
  Future<BirthdayModel> loadBirthdays();
}

class BirthdayRepo implements IBirthdayRepo {
  final BirthdayService _birthdayService = BirthdayService();
  @override
  Future<BirthdayModel> loadBirthdays() async {
    final BirthdayModel birthdayModel = await _birthdayService.getBirthdays();

    return birthdayModel;
  }
}
