import 'package:flutter/cupertino.dart';
import '../../domain/usecases/list_boards_usecase.dart';
import '../../domain/entity/board.dart';

class BoardListProvider with ChangeNotifier {
  final ListBoardsUseCase listBoardsUseCase;

  List<Board> boards = [];
  String message = '';
  bool isLoading = false;

  int totalItems = 0;
  int totalPages = 0;
  int currentPage = 1;

  BoardListProvider({required this.listBoardsUseCase});

  Future<void> listBoards(int page, int perPage) async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      final response = await listBoardsUseCase.call(page, perPage);

      if (response.boards.isEmpty) {
        message = '등록된 내용이 없습니다';
      } else {
        boards = response.boards;
        totalItems = response.totalItems;
        totalPages = response.totalPages; // 서버에서 받아온 totalPages 사용
        currentPage = page;
      }
    } catch (e) {
      message = '게시글을 가져오는 데 오류가 발생했습니다.';
    }

    isLoading = false;
    notifyListeners();
  }

  void changePage(int page, int perPage) {
    listBoards(page, perPage);
  }
}
