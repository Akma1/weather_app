import 'package:dio/dio.dart';
import 'package:weather_app/app/data/configs/app_config.dart';

final Dio auth = Dio(
  BaseOptions(
    baseUrl: AppConfig.BASE_URL,
    receiveDataWhenStatusError: true,
    contentType: Headers.formUrlEncodedContentType,
    responseType: ResponseType.json,
  ),
);

Dio appClient(String key) {
  return Dio(
    BaseOptions(
      baseUrl: key,
      receiveDataWhenStatusError: true,
      contentType: Headers.formUrlEncodedContentType,
      responseType: ResponseType.json,
    ),
  );
}
