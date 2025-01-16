import '../responses/board_list_response.dart';

abstract class ListBoardsUseCase {
  Future<BoardListResponse> call(int page, int perPage);
}
