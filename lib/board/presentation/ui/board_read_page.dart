import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/board_providers.dart';

class BoardReadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BoardProvider>(
      builder: (context, boardProvider, child) {
        final selectedBoard = boardProvider.selectedBoard;

        if (selectedBoard == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Board Detail'),
            ),
            body: Center(
              child: Text('게시글을 불러오는 데 실패했습니다.'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(selectedBoard.title),
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  print('Edit button pressed');
                  // Navigator.pushNamed(context, '/editBoard', arguments: selectedBoard.id);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  print('Delete button pressed');
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('게시글 삭제'),
                      content: Text('정말 이 게시글을 삭제하시겠습니까?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('취소'),
                        ),
                        TextButton(
                          onPressed: () {
                            // boardProvider.deleteBoard(selectedBoard.id);
                            Navigator.of(context).pop(); // Close the dialog
                            Navigator.of(context).pop(); // Go back to the previous page
                          },
                          child: Text('삭제'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedBoard.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '작성자: ${selectedBoard.nickname.isEmpty ? "익명" : selectedBoard.nickname}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  '작성일: ${selectedBoard.createDate}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 16),
                Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      selectedBoard.content,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
