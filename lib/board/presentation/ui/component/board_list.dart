import 'package:flutter/material.dart';
import 'package:flutter_ddd_test/board/presentation/ui/board_read_page.dart';
import 'package:provider/provider.dart';
import '../../../../common_ui/card_item.dart';
import '../../../board_module.dart';
import '../../providers/board_providers.dart';

class BoardList extends StatelessWidget {
  final List<dynamic> boards;

  BoardList({required this.boards});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(boards.length, (index) {
        final board = boards[index];
        if (board == null) {
          return SizedBox(height: 20);  // Placeholder for missing items
        }
        return CardItem(
          title: board.title,
          content: board.content,
          nickname: board.nickname,
          createDate: board.createDate,
          onTap: () async {
            // 비동기적으로 게시글 읽기
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BoardModule.provideBoardReadPage(board.id),
              ),
            );
          },
        );
      }),
    );
  }
}
