// component/page_content.dart
import 'package:flutter/material.dart';
import '../../../../common_ui/pagination.dart';
import '../../providers/board_providers.dart';
import 'board_list.dart';

class PageContent extends StatelessWidget {
  final BoardProvider boardProvider;
  final Function(int) onPageChanged;

  PageContent({required this.boardProvider, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    List<dynamic> boards = List.from(boardProvider.boards);
    while (boards.length < 6) {
      boards.add(null);  // Add null or any placeholder to ensure 6 items
    }

    return Column(
      children: [
        // ListView section
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BoardList(boards: boards),
            ),
          ),
        ),
        // Pagination section at the bottom
        if (boardProvider.totalPages > 0)
          Pagination(
            currentPage: boardProvider.currentPage,
            totalPages: boardProvider.totalPages,
            onPageChanged: onPageChanged,
          ),
      ],
    );
  }
}
