import '../../infrastructure/repository/board_repository.dart';
import '../entity/board.dart';

import 'list_boards_usecase.dart';

class ListBoardsUseCaseImpl implements ListBoardsUseCase {
  final BoardRepository _repository;

  ListBoardsUseCaseImpl(this._repository);

  @override
  Future<List<Board>> call(int page, int perPage) async {
    return await _repository.listBoards(page, perPage);
  }
}
