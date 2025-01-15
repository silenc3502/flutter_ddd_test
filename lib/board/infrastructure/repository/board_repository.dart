import '../../domain/entity/board.dart';

abstract class BoardRepository {
  Future<List<Board>> listBoards(int page, int perPage);
  // Future<Board> createBoard(String title, String content, String userId);
  // Future<Board> getBoard(String id);
  // Future<Board> updateBoard(String id, String title, String content);
  // Future<void> deleteBoard(String id);
}
