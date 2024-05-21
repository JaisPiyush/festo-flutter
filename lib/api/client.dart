import 'package:dio/dio.dart';

class ApiClient {
  late Dio client;

  ApiClient(String baseUrl, {Map<String, dynamic>? headers}) {
    client = Dio(BaseOptions(
        baseUrl: baseUrl, contentType: 'application/json', headers: headers));
  }
}
