import '../../infrastructure/repository/board_repository.dart';
import '../entity/board.dart';
import 'delete_board_usecase.dart';

class DeleteBoardUseCaseImpl implements DeleteBoardUseCase {
  final BoardRepository boardRepository;

  DeleteBoardUseCaseImpl(this.boardRepository);

  @override
  Future<void> execute(int boardId, String userToken) async {
    return await boardRepository.deleteBoard(boardId, userToken);
  }
}
