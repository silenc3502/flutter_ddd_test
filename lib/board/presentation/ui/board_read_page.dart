import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../board_module.dart';
import '../providers/board_read_providers.dart';
import 'board_modify_page.dart';

class BoardReadPage extends StatefulWidget {
  @override
  _BoardReadPageState createState() => _BoardReadPageState();
}

class _BoardReadPageState extends State<BoardReadPage> {
  @override
  void initState() {
    super.initState();
    // 게시글 데이터를 가져옵니다.
    final boardReadProvider =
    Provider.of<BoardReadProvider>(context, listen: false);

    if (boardReadProvider.board == null) {
      boardReadProvider.fetchBoard();
    }
  }

  @override
  Widget build(BuildContext context) {
    final boardReadProvider = Provider.of<BoardReadProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('게시글 상세보기'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              final selectedBoard = boardReadProvider.board;
              if (selectedBoard != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BoardModule.provideBoardModifyPage(
                      selectedBoard.id,
                      selectedBoard.title,
                      selectedBoard.content,
                    ),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _showDeleteDialog(context, boardReadProvider),
          ),
        ],
      ),
      body: _buildBody(boardReadProvider),
    );
  }

  Widget _buildBody(BoardReadProvider boardReadProvider) {
    if (boardReadProvider.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (boardReadProvider.error != null) {
      return Center(
        child: Text(
          '게시글을 불러오는 데 실패했습니다.\n${boardReadProvider.error}',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red),
        ),
      );
    } else if (boardReadProvider.board == null) {
      return Center(child: Text('게시글을 찾을 수 없습니다.'));
    }

    final board = boardReadProvider.board!;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            board.title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '작성자: ${board.nickname.isEmpty ? "익명" : board.nickname}',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            '작성일: ${board.createDate}',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                board.content,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, BoardReadProvider boardReadProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('게시글 삭제'),
        content: Text('정말 이 게시글을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () {
              // boardReadProvider.deleteBoard();
              Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).pop(); // Go back to the previous page
            },
            child: Text('삭제'),
          ),
        ],
      ),
    );
  }
}
