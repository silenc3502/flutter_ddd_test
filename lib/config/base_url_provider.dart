import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseUrlProvider with ChangeNotifier {
  late String _baseUrl;

  BaseUrlProvider() {
    _baseUrl = dotenv.env['BASE_URL'] ?? _throwBaseUrlError();
  }

  String get baseUrl => _baseUrl;

  // BASE_URL이 없으면 예외 던지기
  String _throwBaseUrlError() {
    throw Exception('BASE_URL 환경 변수가 설정되지 않았습니다!');
  }
}
