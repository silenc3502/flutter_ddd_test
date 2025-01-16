import '../../domain/responses/board_list_response.dart';
import '../../domain/entity/board.dart';
import '../../infrastructure/repository/board_repository.dart';
import 'list_boards_usecase.dart';

class ListBoardsUseCaseImpl implements ListBoardsUseCase {
  final BoardRepository _repository;

  ListBoardsUseCaseImpl(this._repository);

  @override
  Future<BoardListResponse> call(int page, int perPage) async {
    print('Calling use case to fetch boards...');

    try {
      // Repository에서 데이터를 받아옴
      final BoardListResponse response = await _repository.listBoards(page, perPage);
      print('Fetched boards from use case: $response');

      // BoardListResponse를 반환
      return response;
    } catch (e) {
      print('Error in ListBoardsUseCaseImpl: $e');
      throw Exception('Failed to fetch boards');
    }
  }
}
