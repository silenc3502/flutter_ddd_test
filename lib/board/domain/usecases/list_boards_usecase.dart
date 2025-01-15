import '../entity/board.dart';

abstract class ListBoardsUseCase {
  Future<List<Board>> call(int page, int perPage);
}
