import 'package:dio/dio.dart';
import '../../constants/api_constatnts.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
        required String url,
    Map<String, dynamic>? data,
    String lang = 'ar'
      }) async {
    return await dio.get(
        url,
        queryParameters: {
          'api_key' : '6b95535dcef0dd4e6401b7cf552c8865',
          'language' : lang
        },
        data: data
    );
  }
}
