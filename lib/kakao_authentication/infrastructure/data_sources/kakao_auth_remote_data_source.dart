import 'dart:convert';
import 'package:http/http.dart' as http;

class KakaoAuthRemoteDataSource {
  final String baseUrl;

  KakaoAuthRemoteDataSource(this.baseUrl);

  Future<String> loginWithKakao(String authorizationCode) async {
    print('Requesting login with Kakao from: $baseUrl/kakao/login?code=$authorizationCode');

    final response = await http.post(
      Uri.parse('$baseUrl/kakao/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'authorizationCode': authorizationCode}),
    );

    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Response data: $data');

      // 예시로 토큰을 응답에서 추출한다고 가정
      String accessToken = data['accessToken'] ?? '';
      return accessToken;
    } else {
      print('Error: Failed to authenticate with Kakao');
      throw Exception('Failed to authenticate with Kakao');
    }
  }

  Future<void> logoutFromKakao(String accessToken) async {
    print('Logging out from Kakao with token: $accessToken');

    final response = await http.post(
      Uri.parse('$baseUrl/kakao/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken', // 인증 헤더에 access token 포함
      },
    );

    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('Successfully logged out from Kakao');
    } else {
      print('Error: Failed to logout from Kakao');
      throw Exception('Failed to logout from Kakao');
    }
  }
}
