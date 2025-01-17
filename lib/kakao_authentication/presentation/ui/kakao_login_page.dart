import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KakaoLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final kakaoAuthProvider = Provider.of<KakaoAuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Kakao Login"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: kakaoAuthProvider.isLoggedIn
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome, ${kakaoAuthProvider.user?.nickname ?? 'User'}!",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await kakaoAuthProvider.logout();
                Navigator.pop(context);
              },
              child: Text("Log Out"),
            ),
          ],
        )
            : ElevatedButton(
          onPressed: () async {
            await kakaoAuthProvider.login();
            await kakaoAuthProvider.fetchUserInfo();
            Navigator.pop(context);
          },
          child: Text("Log in with Kakao"),
        ),
      ),
    );
  }
}
