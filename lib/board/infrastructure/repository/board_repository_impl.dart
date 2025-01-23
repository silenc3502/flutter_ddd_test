import '../../domain/entity/board.dart';
import '../../domain/responses/board_list_response.dart';
import '../data_sources/board_remote_data_source.dart';
import 'board_repository.dart';

class BoardRepositoryImpl implements BoardRepository {
  final BoardRemoteDataSource remoteDataSource;

  BoardRepositoryImpl(this.remoteDataSource);

  @override
  Future<BoardListResponse> listBoards(int page, int perPage) async {
    try {
      final response = await remoteDataSource.listBoards(page, perPage);
      return response; // BoardListResponse 반환
    } catch (e) {
      print('Error in BoardRepositoryImpl: $e');
      throw Exception('Error fetching boards: $e');
    }
  }

  @override
  Future<Board> createBoard(
      String title, String content, String userToken) async {
    print(
        '[BoardRepositoryImpl] Creating board with title: $title, content: $content, userToken: $userToken');
    try {
      final board =
          await remoteDataSource.createBoard(title, content, userToken);
      print('[BoardRepositoryImpl] Board created successfully: $board');
      return board;
    } catch (e) {
      print('[BoardRepositoryImpl] Error: $e');
      throw Exception('Failed to create board');
    }
  }

  @override
  Future<Board?> readBoard(int boardId) async {
    try {
      print('Attempting to read board with ID: $boardId'); // boardId 출력

      // 데이터 받아오기
      final board = await remoteDataSource.fetchBoard(boardId);

      // 데이터를 출력
      if (board != null) {
        print(
            'readBoard() Board data fetched: ${board.toJson()}'); // Board 객체의 데이터를 JSON 형태로 출력
      } else {
        print('No board found for ID: $boardId');
      }

      return board; // 데이터 반환
    } catch (e) {
      print('Error fetching board from repository: $e'); // 예외 발생 시 출력
      return null;
    }
  }

  @override
  Future<Board> updateBoard(
      int boardId, String title, String content, String userToken) async {
    try {
      print('Attempting to update board with ID: $boardId');
      print('New title: $title, content: $content, userToken: $userToken');

      // 데이터 업데이트
      final updatedBoard = await remoteDataSource.updateBoard(
          boardId, title, content, userToken);

      print('Board updated successfully: ${updatedBoard.toJson()}');
      return updatedBoard;
    } catch (e) {
      print('Error updating board: $e');
      rethrow; // 상위 호출자에게 예외 전달
    }
  }
}
