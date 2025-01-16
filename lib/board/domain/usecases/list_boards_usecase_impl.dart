import '../../infrastructure/repository/board_repository.dart';
import '../entity/board.dart';
import 'list_boards_usecase.dart';

class ListBoardsUseCaseImpl implements ListBoardsUseCase {
  final BoardRepository _repository;

  ListBoardsUseCaseImpl(this._repository);

  @override
  Future<List<Board>> call(int page, int perPage) async {
    print('Calling use case to fetch boards...');
    final boards = await _repository.listBoards(page, perPage);
    print('Fetched boards from use case: $boards');
    return boards;
  }
}
