import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import '../../../board/board_module.dart';
import '../../../common_ui/app_bar_action.dart';
import '../../../kakao_authentication/kakao_auth_module.dart';
import '../../../kakao_authentication/presentation/providers/kakao_auth_providers.dart';
import '../../../simple_chat/presentation/ui/simple_chat_page.dart';
import '../../../simple_chat/simple_chat_module.dart';

class HomePage extends StatelessWidget {
  final String apiUrl = dotenv.env['API_URL'] ?? '';
  final String apiKey = dotenv.env['API_KEY'] ?? '';

  @override
  Widget build(BuildContext context) {
    final kakaoAuthProvider = Provider.of<KakaoAuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.deepPurple,
        actions: [
          // 게시판 아이콘
          AppBarAction(
            icon: Icons.list_alt,
            tooltip: 'Board List',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BoardModule.provideBoardListPage(),
                ),
              );
            },
          ),
          // 로그인 아이콘
          AppBarAction(
            icon: kakaoAuthProvider.isLoggedIn ? Icons.logout : Icons.login,
            tooltip: kakaoAuthProvider.isLoggedIn ? 'Logout' : 'Login',
            onPressed: () {
              if (kakaoAuthProvider.isLoggedIn) {
                kakaoAuthProvider.logoutFromKakao();
                // Optionally show a logout message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logged out successfully')),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        KakaoAuthModule.provideKakaoLoginPage(),
                  ),
                );
              }
            },
          ),
          // Simple Chat 페이지로 이동하는 버튼 추가
          AppBarAction(
            icon: Icons.chat_bubble,
            tooltip: 'Go to Simple Chat',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SimpleChatModule.provideSimpleChatPage(apiUrl, apiKey),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          kakaoAuthProvider.isLoggedIn
              ? 'Welcome, ${kakaoAuthProvider.message}' // Example welcome message with user info
              : 'Welcome to Home Page! Please login to continue.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
