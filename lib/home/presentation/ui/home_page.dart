import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import '../../../kakao_authentication/presentation/providers/kakao_auth_providers.dart';
import '../../../common_ui/custom_app_bar.dart'; // CustomAppBar import

class HomePage extends StatelessWidget {
  final String apiUrl = dotenv.env['API_URL'] ?? '';
  final String apiKey = dotenv.env['API_KEY'] ?? '';

  @override
  Widget build(BuildContext context) {
    final kakaoAuthProvider = Provider.of<KakaoAuthProvider>(context);

    return Scaffold(
      body: CustomAppBar(
        body: Center(
          child: Text(
            kakaoAuthProvider.isLoggedIn
                ? 'Welcome, ${kakaoAuthProvider.message}' // 로그인된 사용자에게 환영 메시지
                : 'Welcome to Home Page! Please login to continue.', // 로그인되지 않은 사용자에게 메시지
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        title: 'Home', // CustomAppBar의 타이틀
      ),
    );
  }
}
