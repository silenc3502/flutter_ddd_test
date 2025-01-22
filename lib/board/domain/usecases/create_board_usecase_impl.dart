import '../../infrastructure/repository/board_repository.dart';
import '../entity/board.dart';
import 'create_board_usecase.dart';

class CreateBoardUseCaseImpl implements CreateBoardUseCase {
  final BoardRepository repository;

  CreateBoardUseCaseImpl(this.repository);

  @override
  Future<Board> execute(String title, String content, String userToken) async {
    try {
      return await repository.createBoard(title, content, userToken);
    } catch (e) {
      throw Exception('Error executing createBoard use case: $e');
    }
  }
}
