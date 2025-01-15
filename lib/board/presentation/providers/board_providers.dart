import 'package:flutter/material.dart';
import '../../domain/entity/board.dart';
import '../../domain/usecases/list_boards_usecase.dart';

class BoardProvider with ChangeNotifier {
  final ListBoardsUseCase listBoardsUseCase;
  List<Board> boards = [];
  bool isLoading = false;
  String message = ''; // 메시지 추가

  BoardProvider({required this.listBoardsUseCase});

  Future<void> listBoards(int page, int perPage) async {
    isLoading = true;
    notifyListeners();

    try {
      final data = await listBoardsUseCase(page, perPage);
      if (data.isEmpty) {
        message = '등록된 내용이 없습니다'; // 데이터가 없을 때 메시지 처리
      } else {
        boards = data;
      }
    } catch (e) {
      message = '게시글을 가져오는 데 오류가 발생했습니다.';
    }

    isLoading = false;
    notifyListeners();
  }
}
