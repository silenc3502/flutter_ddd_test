// common_ui/pagination.dart
import 'package:flutter/material.dart';
import '../common_ui/page_button.dart';

class Pagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (currentPage > 1)
            PageButton(
              label: 'Prev',
              page: currentPage - 1,
              isCurrentPage: false,
              onTap: () => onPageChanged(currentPage - 1),
            ),
          ...List.generate(totalPages, (index) {
            int pageNum = index + 1;
            return PageButton(
              label: '$pageNum',
              page: pageNum,
              isCurrentPage: pageNum == currentPage,
              onTap: () => onPageChanged(pageNum),
            );
          }),
          if (currentPage < totalPages)
            PageButton(
              label: 'Next',
              page: currentPage + 1,
              isCurrentPage: false,
              onTap: () => onPageChanged(currentPage + 1),
            ),
        ],
      ),
    );
  }
}
