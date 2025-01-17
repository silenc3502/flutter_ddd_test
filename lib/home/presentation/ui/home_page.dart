import 'package:flutter/material.dart';
import '../../../board/board_module.dart';
import '../../../common_ui/app_bar_action.dart';
import '../../../kakao_authentication/kakao_auth_module.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          // AppBarAction(
          //   icon: kakaoAuthProvider.isLoggedIn ? Icons.logout : Icons.login,
          //   tooltip: kakaoAuthProvider.isLoggedIn ? 'Logout' : 'Login',
          //   onPressed: () {
          //     if (kakaoAuthProvider.isLoggedIn) {
          //       kakaoAuthProvider.logout();
          //     } else {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => KakaoAuthModule.provideKakaoLoginPage(),
          //         ),
          //       );
          //     }
          //   },
          // ),
        ],
      ),
      body: Center(
        child: Text('Welcome to Home Page!'),
      ),
    );
  }
}
