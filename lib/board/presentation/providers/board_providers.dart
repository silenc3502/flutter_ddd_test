import 'package:flutter/material.dart';
import '../../domain/entity/board.dart';
import '../../domain/usecases/list_boards_usecase.dart';

class BoardProvider with ChangeNotifier {
  final ListBoardsUseCase listBoardsUseCase;
  List<Board> boards = [];
  bool isLoading = false;
  String message = '';
  int totalItems = 0;  // totalItems 값 추가
  int totalPages = 0;  // totalPages 값 추가

  BoardProvider({required this.listBoardsUseCase}) {
    _initBoards();
  }

  Future<void> _initBoards() async {
    await listBoards(1, 10);
  }

  Future<void> listBoards(int page, int perPage) async {
    isLoading = true;
    notifyListeners();

    try {
      // 수정된 부분: `call` 메소드 명시적으로 호출
      final data = await listBoardsUseCase.call(page, perPage);  // `call`을 명시적으로 호출

      print('Received boards data: $data');  // 데이터 출력 추가

      if (data.isEmpty) {
        message = '등록된 내용이 없습니다';
      } else {
        boards = data;
        // 페이지네이션 정보 업데이트
        totalItems = data.length;  // 데이터를 기반으로 총 아이템 수 업데이트
        totalPages = (totalItems / perPage).ceil();  // 전체 페이지 수 계산
      }
    } catch (e) {
      message = '게시글을 가져오는 데 오류가 발생했습니다.';
      print('Error: $e');  // 에러 출력 추가
    }

    isLoading = false;
    notifyListeners();
  }
}
