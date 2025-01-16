import '../entity/board.dart';

class BoardListResponse {
  final List<Board> boards;
  final int totalItems;
  final int totalPages;

  BoardListResponse({
    required this.boards,
    required this.totalItems,
    required this.totalPages,
  });
}
