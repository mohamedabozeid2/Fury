import 'package:dio/dio.dart';

class RemoteNotificationHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://fcm.googleapis.com/fcm/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> sendNotification({
    required String url,
    required Map<String, dynamic> data,
    String? lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return await dio!.post(url, data: data);
  }

}
