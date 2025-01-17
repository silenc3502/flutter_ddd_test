import 'package:flutter/material.dart';

import '../../../../common_ui/card_item.dart';

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
        );
      }),
    );
  }
}
