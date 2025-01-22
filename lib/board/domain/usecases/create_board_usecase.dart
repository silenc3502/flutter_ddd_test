import '../entity/board.dart';

abstract class CreateBoardUseCase {
  Future<Board> execute(String title, String content, String userToken);
}
