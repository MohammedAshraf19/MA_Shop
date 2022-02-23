import 'package:dio/dio.dart';

class DioHelperShop{

  static late Dio dio;

  static init(){
    dio =Dio(
        BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type':'application/json',
            'lang':'ar'
          },
        )
    );
  }

  static Future<Response>getData({
    required String url,
    Map<String,dynamic>? query,
    String lang='en',
    String? token,
  })async{
    dio.options.headers={
      'lang':lang,
      'Authorization':token
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response>postData({
    required String url,
    required Map<String,dynamic> data,
    Map<String,dynamic>? query,
    String lang='en',
    String? token,
  })async{
    dio.options.headers={
      'lang':lang,
      'Authorization':token
    };
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }


  static Future<Response>putData({
    required String url,
    required Map<String,dynamic> data,
    Map<String,dynamic>? query,
    String lang='en',
    String? token,
  })async{
    dio.options.headers={
      'lang':lang,
      'Authorization':token
    };
    return await dio.put(
      url,
      data: data,
      queryParameters: query,
    );
  }

}