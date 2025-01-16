import 'package:flutter/material.dart';
import '../../domain/entity/board.dart';
import '../../domain/usecases/list_boards_usecase.dart';

class BoardProvider with ChangeNotifier {
  final ListBoardsUseCase listBoardsUseCase;
  List<Board> boards = [];
  bool isLoading = false;
  String message = '';
  int totalItems = 0;
  int totalPages = 0;
  int currentPage = 1;

  BoardProvider({required this.listBoardsUseCase}) {
    _initBoards();
  }

  Future<void> _initBoards() async {
    await listBoards(currentPage, 6);  // 초기 페이지 로드
  }

  Future<void> listBoards(int page, int perPage) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await listBoardsUseCase.call(page, perPage);

      if (response.boards.isEmpty) {
        message = '등록된 내용이 없습니다';
      } else {
        boards = response.boards;
        totalItems = response.totalItems;
        totalPages = response.totalPages;  // 서버에서 받아온 totalPages 사용
        currentPage = page;
      }
    } catch (e) {
      message = '게시글을 가져오는 데 오류가 발생했습니다.';
    }

    isLoading = false;
    notifyListeners();
  }

  void changePage(int page) async {
    if (page >= 1 && page <= totalPages) {
      await listBoards(page, 6);  // 페이지 변경 시 해당 페이지 데이터를 요청
    }
  }
}
