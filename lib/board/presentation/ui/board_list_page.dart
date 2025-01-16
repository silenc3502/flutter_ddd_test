import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/board_providers.dart';

class BoardListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Board List'),
        backgroundColor: Colors.deepPurple, // 색상 변경
        elevation: 0, // 그림자 제거
      ),
      body: Consumer<BoardProvider>(
        builder: (context, boardProvider, child) {
          if (boardProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (boardProvider.message.isNotEmpty) {
            return Center(child: Text(boardProvider.message));
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.0), // ListView에 패딩 추가
            itemCount: boardProvider.boards.length,
            itemBuilder: (context, index) {
              final board = boardProvider.boards[index];
              return Card(
                elevation: 5, // 카드 그림자 효과 추가
                margin: EdgeInsets.symmetric(vertical: 8), // 카드 간의 간격
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // 둥근 카드 모서리
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // 카드 내부 여백
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        board.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple, // 제목 색상
                        ),
                      ),
                      SizedBox(height: 8), // 제목과 내용 간격
                      Text(
                        board.content,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87, // 내용 색상
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis, // 내용이 길면 잘리도록 설정
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            board.nickname.isEmpty ? '익명' : board.nickname,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            board.createDate,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
