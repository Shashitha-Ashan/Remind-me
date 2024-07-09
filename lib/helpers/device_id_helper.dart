import 'package:dio/dio.dart';

class DeviceIdHelper {
  static final Dio _dio = Dio();

  static Future<dynamic> updateDeviceId(
      {required String deviceId, required String uid}) async {
    try {
      print(uid);
      final res = await _dio.post(
          "https://remind-me-server.vercel.app/api/updatedeviceid",
          data: {"deviceId": deviceId, "userId": uid});
      return res;
    } catch (e) {}
  }
}
