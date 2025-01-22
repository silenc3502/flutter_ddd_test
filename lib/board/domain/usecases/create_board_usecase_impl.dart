import '../../infrastructure/repository/board_repository.dart';
import '../entity/board.dart';
import 'create_board_usecase.dart';

class CreateBoardUseCaseImpl implements CreateBoardUseCase {
  final BoardRepository repository;

  CreateBoardUseCaseImpl(this.repository);

  @override
  Future<Board> execute(String title, String content, String userToken) async {
    print(
        '[CreateBoardUseCaseImpl] Executing createBoard with title: $title, content: $content, userToken: $userToken');
    try {
      final board = await repository.createBoard(title, content, userToken);
      print('[CreateBoardUseCaseImpl] Board created successfully: $board');
      return board;
    } catch (e) {
      print('[CreateBoardUseCaseImpl] Error: $e');
      throw Exception('Error executing createBoard use case: $e');
    }
  }
}
