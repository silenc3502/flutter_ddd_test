import '../../infrastructure/repository/board_repository.dart';
import '../entity/board.dart';
import 'read_board_usecase.dart';

class ReadBoardUseCaseImpl implements ReadBoardUseCase {
  final BoardRepository boardRepository;

  ReadBoardUseCaseImpl(this.boardRepository);

  @override
  Future<Board?> execute(int boardId) async {
    try {
      print('Executing ReadBoardUseCase for boardId: $boardId');  // boardId 출력
      final board = await boardRepository.readBoard(boardId);  // Repository 호출

      if (board != null) {
        print('ReadBoardUseCaseImpl() Board data fetched successfully: ${board.toJson()}');  // 반환 전에 데이터 출력
      } else {
        print('No board found for ID: $boardId');
      }
      return board;
    } catch (e) {
      print('Error in ReadBoardUseCase: $e');  // 예외 발생 시 출력
      return null;
    }
  }
}
