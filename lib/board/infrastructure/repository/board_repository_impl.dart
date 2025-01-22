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
  Future<Board> createBoard(String title, String content, String userToken) {
    return remoteDataSource.createBoard(title, content, userToken);
  }
}
