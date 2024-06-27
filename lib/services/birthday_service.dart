import 'package:birth_daily/models/birthday/birthday_model.dart';
import 'package:dio/dio.dart';

class BirthdayService {
  late BirthdayModel birthdayModel;
  final _dio = Dio();

  Future<BirthdayModel> getBirthdays() async {
    final response = await _dio.get('http://localhost:3000/api/');
    birthdayModel = BirthdayModel(dateTime: DateTime.now(), name: "Ashan");
    return birthdayModel;
  }
}
