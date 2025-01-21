import 'package:flutter/material.dart';
import 'package:flutter_ddd_test/simple_chat/presentation/providers/simple_chat_provider.dart';
import 'package:provider/provider.dart';

import '../../../kakao_authentication/presentation/providers/kakao_auth_providers.dart';

class SimpleChatPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Chat'),
        actions: [
          Consumer<KakaoAuthProvider>(
            builder: (context, authProvider, child) {
              return authProvider.isLoggedIn
                  ? IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () async {
                  await authProvider.logoutFromKakao();
                  // 로그아웃 후 로그인 페이지로 이동
                  Navigator.pushReplacementNamed(context, '/kakao-login');
                },
              )
                  : Container(); // 로그인 안 됐을 때는 버튼 숨김
            },
          ),
        ],
      ),
      body: Consumer<SimpleChatProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: provider.messages.length,
                  itemBuilder: (context, index) {
                    final message = provider.messages[index];
                    return ListTile(
                      title: Text(message.content),
                      subtitle: Text(message.timestamp.toString()),
                    );
                  },
                ),
              ),
              if (provider.isLoading) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        final message = _controller.text;
                        if (message.isNotEmpty) {
                          provider.addUserMessage(message);
                          provider.sendMessage(message, context);
                          _controller.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
