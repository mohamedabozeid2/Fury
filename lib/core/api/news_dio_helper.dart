import 'package:dio/dio.dart';

class NewsDioHelper{
  static Dio? dio;
  static String apiKey = 'b08371119bd34917a135197f688bd938';
  static init(){
    dio=Dio(
        BaseOptions(
          baseUrl: 'https://newsapi.org',
          receiveDataWhenStatusError: true,
        )
    );
  }



  static Future<Response> getData({
    required String url,
    Map<String,dynamic>? query,
    String? lang='en-US',
  })async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
    };
    return await dio!.get(url,queryParameters: query??null);
  }

  static Future<Response> postData({
    required String? url,
    required Map<String,dynamic>? data,
    String? lang='en-US',
  })async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
    };

    return await dio!.post(url!,data: data!);
  }

  static Future<Response> putData({
    required String? url,
    required Map<String,dynamic>? data,
    String? lang='en',
    String? token,
  })async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token??'',
    };

    return await dio!.put(url!,data: data!);
  }

}