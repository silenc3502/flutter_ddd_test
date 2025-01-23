import 'package:flutter_ddd_test/board/domain/usecases/update_board_usecase.dart';

import '../../infrastructure/repository/board_repository.dart';
import '../entity/board.dart';

class UpdateBoardUseCaseImpl implements UpdateBoardUseCase {
  final BoardRepository boardRepository;

  UpdateBoardUseCaseImpl(this.boardRepository);

  @override
  Future<Board> execute(
      int boardId, String title, String content, String userToken) async {
    return await boardRepository.updateBoard(
        boardId, title, content, userToken);
  }
}
