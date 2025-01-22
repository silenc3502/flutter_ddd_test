import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../common_ui/app_bar_action.dart';
import '../../../kakao_authentication/kakao_auth_module.dart';
import '../../../simple_chat/simple_chat_module.dart';
import '../board/board_module.dart';

class CustomAppBar extends StatelessWidget {
  final String apiUrl = dotenv.env['API_URL'] ?? '';
  final String apiKey = dotenv.env['API_KEY'] ?? '';

  final Widget body;
  final String title;

  CustomAppBar({
    required this.body,
    this.title = 'Home',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
            icon: Icons.login, // 로그인 상태에 따라 아이콘 변경
            tooltip: 'Login',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KakaoAuthModule.provideKakaoLoginPage(),
                ),
              );
            },
          ),
          // Simple Chat 페이지로 이동하는 버튼
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
      body: body,
    );
  }
}
