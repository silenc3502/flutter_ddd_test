import '../entity/board.dart';

abstract class UpdateBoardUseCase {
  Future<void> call(Board board);
}
