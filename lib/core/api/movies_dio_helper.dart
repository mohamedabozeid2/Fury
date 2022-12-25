import 'package:dio/dio.dart';

class MoviesDioHelper{
  static Dio? dio;
  static String apiKey = 'a33a26fbf615c3f68bcd6ebc1fb6e018';
  static String baseImageURL = 'https://image.tmdb.org/t/p/original';
  static init(){
    dio=Dio(
        BaseOptions(
          baseUrl: 'https://api.themoviedb.org/3',
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
    return await dio!.get(url,queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required Map<String,dynamic> data,
    Map<String,dynamic>? query,
    String? lang='en-US',
  })async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
    };

    return await dio!.post(url,data: data,queryParameters: query?? null);
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