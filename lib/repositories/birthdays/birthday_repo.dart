import 'package:birth_daily/models/birthday/birthday_model.dart';

abstract class IBirthdayRepo {
  Future<BirthdayModel> loadBirthdays();
}

class BirthdayRepo implements IBirthdayRepo {
  final BirthdayModel birthdayModel;
  BirthdayRepo({required this.birthdayModel});
  @override
  Future<BirthdayModel> loadBirthdays() async {
    Future.delayed(const Duration(seconds: 3));
    return birthdayModel;
  }
}
