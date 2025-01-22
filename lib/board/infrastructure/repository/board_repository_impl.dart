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
}
