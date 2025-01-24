import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/board_create_providers.dart';

class BoardCreatePage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Board')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<BoardCreateProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(labelText: 'Content'),
                ),
                SizedBox(height: 20),
                if (provider.isLoading)
                  CircularProgressIndicator(), // 로딩 상태 표시
                if (provider.message.isNotEmpty)
                  Text(provider.message), // 메시지 표시
                ElevatedButton(
                  onPressed: () {
                    final title = titleController.text;
                    final content = contentController.text;

                    // 게시글 생성 호출
                    provider.createBoard(title, content);
                  },
                  child: Text('Send'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
