import 'package:flutter/material.dart';
import 'package:flutter_ddd_test/board/presentation/ui/board_read_page.dart';
import 'package:provider/provider.dart';
import '../../../../common_ui/card_item.dart';
import '../../../board_module.dart';
import '../../../domain/entity/board.dart';
import '../../providers/board_list_providers.dart';
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
          return SizedBox(height: 20); // Placeholder for missing items
        }
        return CardItem(
          title: board.title,
          content: board.content,
          nickname: board.nickname,
          createDate: board.createDate,
          onTap: () async {
            // 비동기적으로 게시글 읽기
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BoardModule.provideBoardReadPage(board.id),
              ),
            );

            // 반환값 처리
            if (result != null) {
              final boardListProvider =
                  Provider.of<BoardListProvider>(context, listen: false);

              if (result['deleted'] == true) {
                // 게시글 삭제 처리
                boardListProvider.listBoards(
                  boardListProvider.currentPage, // 현재 페이지 유지
                  6, // 고정된 perPage 값
                );
                // boardListProvider.removeBoard();
              } else if (result['updatedBoard'] != null &&
                  result['updatedBoard'] is Board) {
                // 게시글 수정 처리
                final updatedBoard = result['updatedBoard'] as Board;
                boardListProvider.updateBoard(updatedBoard);
              }
            }
          },
        );
      }),
    );
  }
}
