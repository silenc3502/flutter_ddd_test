import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../board_module.dart';
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
                if (provider.isLoading) CircularProgressIndicator(), // 로딩 상태 표시
                if (provider.message.isNotEmpty)
                  Text(provider.message,
                      style: TextStyle(color: Colors.red)), // 메시지 표시
                ElevatedButton(
                  onPressed: () async {
                    final title = titleController.text.trim();
                    final content = contentController.text.trim();

                    if (title.isEmpty || content.isEmpty) {
                      provider.message = '제목과 내용을 모두 입력해주세요.';
                      provider.notifyListeners();
                      return;
                    }

                    // 게시글 생성 호출
                    final board = await provider.createBoard(title, content);

                    if (board != null) {
                      // 생성 성공 시 읽기 페이지로 이동
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BoardModule.provideBoardReadPage(board.id),
                        ),
                      );
                    }
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
