import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entity/board.dart';
import '../providers/board_providers.dart';

class BoardModifyPage extends StatefulWidget {
  final int boardId;

  BoardModifyPage({required this.boardId});

  @override
  _BoardModifyPageState createState() => _BoardModifyPageState();
}

class _BoardModifyPageState extends State<BoardModifyPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    // 게시글 정보를 가져와서 초기화합니다.
    final boardProvider = Provider.of<BoardProvider>(context, listen: false);
    final selectedBoard = boardProvider.getBoardById(widget.boardId);

    _titleController = TextEditingController(text: selectedBoard?.title ?? '');
    _contentController = TextEditingController(text: selectedBoard?.content ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardProvider>(
      builder: (context, boardProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('게시글 수정'),
            actions: [
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  final updatedBoard = Board(
                    id: widget.boardId,
                    title: _titleController.text,
                    content: _contentController.text,
                    nickname: "", // 수정하지 않으면 이전 값 그대로
                    createDate: "", // 수정하지 않으면 이전 값 그대로
                  );

                  // 수정된 내용을 저장하는 로직 추가
                  boardProvider.updateBoard(updatedBoard);
                  Navigator.pop(context); // 수정 완료 후 이전 페이지로 돌아가기
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
                  '제목',
                  style: TextStyle(fontSize: 18),
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: '게시글 제목을 입력하세요',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '내용',
                  style: TextStyle(fontSize: 18),
                ),
                TextField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    hintText: '게시글 내용을 입력하세요',
                  ),
                  maxLines: 6, // 여러 줄 입력을 위해
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
