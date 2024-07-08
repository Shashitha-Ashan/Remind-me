import 'package:dio/dio.dart';

class DeviceIdHelper {
  static final Dio _dio = Dio();

  static Future<dynamic> updateDeviceId({required String deviceId}) async {
    final res = await _dio.post("", data: {'deviceId': deviceId});
    return res.data;
  }
}
