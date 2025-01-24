import '../../domain/entity/board.dart';
import '../../domain/responses/board_list_response.dart';

abstract class BoardRepository {
  Future<BoardListResponse> listBoards(int page, int perPage);
  Future<Board> createBoard(String title, String content, String userToken);
  Future<Board?> readBoard(int id);
  Future<Board?> updateBoard(
      int boardId, String title, String content, String userToken);
  Future<void> deleteBoard(int id, String userToken);
}
