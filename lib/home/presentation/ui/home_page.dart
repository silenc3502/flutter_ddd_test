import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import '../../../kakao_authentication/presentation/providers/kakao_auth_providers.dart';
import '../../../kakao_authentication/kakao_auth_module.dart';
import '../../../common_ui/app_bar_action.dart';
import '../../../simple_chat/simple_chat_module.dart';
import '../../../board/board_module.dart';
import '../../../common_ui/custom_app_bar.dart'; // CustomAppBar import

class HomePage extends StatelessWidget {
  final String apiUrl = dotenv.env['API_URL'] ?? '';
  final String apiKey = dotenv.env['API_KEY'] ?? '';

  @override
  Widget build(BuildContext context) {
    final kakaoAuthProvider = Provider.of<KakaoAuthProvider>(context);

    return CustomAppBar(
      body: Center(
        child: Text(
          kakaoAuthProvider.isLoggedIn
              ? 'Welcome, ${kakaoAuthProvider.message}' // Example welcome message with user info
              : 'Welcome to Home Page! Please login to continue.',
          style: TextStyle(fontSize: 18),
        ),
      ),
      title: 'Home',
    );
  }
}
