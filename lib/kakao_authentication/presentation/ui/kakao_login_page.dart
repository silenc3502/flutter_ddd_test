import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common_ui/custom_app_bar.dart'; // CustomAppBar import
import '../providers/kakao_auth_providers.dart';

class KakaoLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppBar(
        body: Consumer<KakaoAuthProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return Center(
              child: provider.isLoggedIn
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '로그인 성공!',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: provider.isLoading
                        ? null
                        : () => provider.logoutFromKakao(),
                    child: Text('Logout'),
                  ),
                  if (provider.message.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        provider.message,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed:
                    provider.isLoading ? null : () => provider.login(),
                    child: Text('Login with Kakao'),
                  ),
                  if (provider.message.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        provider.message,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        title: 'Kakao Login',
      ),
    );
  }
}
