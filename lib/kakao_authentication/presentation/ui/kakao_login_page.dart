import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/kakao_auth_providers.dart';

class KakaoLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kakao Login'),
      ),
      body: Consumer<KakaoAuthProvider>(
        builder: (context, provider, child) {
          return Center(
            child: provider.isLoggedIn
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('로그인 성공!'),
                      ElevatedButton(
                        onPressed: () {
                          provider.logoutFromKakao();
                        },
                        child: Text('Logout'),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      provider.loginWithKakao();
                    },
                    child: Text('Login with Kakao'),
                  ),
          );
        },
      ),
    );
  }
}
