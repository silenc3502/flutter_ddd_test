import '../../domain/entity/board.dart';
import '../data_sources/board_remote_data_source.dart';
import 'board_repository.dart';

class BoardRepositoryImpl implements BoardRepository {
  final BoardRemoteDataSource remoteDataSource;

  BoardRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Board>> listBoards(int page, int perPage) async {
    try {
      final data = await remoteDataSource.listBoards(page, perPage);
      return data.map((item) {
        return Board(
          id: item['boardId'], // 예시로 boardId 사용
          title: item['title'] ?? 'Untitled', // title이 null이면 'Untitled'로 대체
          content: item['content'] ?? '', // content가 null이면 빈 문자열로 대체
          nickname: item['nickname'] ?? 'Anonymous', // nickname이 null이면 'Anonymous'로 대체
          createDate: item['createDate'] ?? 'Unknown', // createDate가 null이면 'Unknown'으로 대체
        );
      }).toList();
    } catch (e) {
      throw Exception('Error fetching boards: $e');
    }
  }
}
