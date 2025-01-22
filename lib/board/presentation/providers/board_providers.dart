import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entity/board.dart';
import '../../domain/usecases/create_board_usecase.dart';
import '../../domain/usecases/list_boards_usecase.dart';

class BoardProvider with ChangeNotifier {
  final ListBoardsUseCase listBoardsUseCase;
  final CreateBoardUseCase createBoardUseCase;  // CreateBoardUseCase 추가
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  List<Board> boards = [];
  bool isLoading = false;
  String message = '';
  int totalItems = 0;
  int totalPages = 0;
  int currentPage = 1;

  BoardProvider({
    required this.listBoardsUseCase,
    required this.createBoardUseCase,  // 생성자에서 전달
  }) {
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

  // 게시물 생성 메소드 추가
  Future<void> createBoard(String title, String content) async {
    isLoading = true;
    notifyListeners();

    try {
      final userToken = await _secureStorage.read(key: 'userToken');

      if (userToken == null) {
        message = '로그인 상태가 아닙니다.';
        isLoading = false;
        notifyListeners();
        return;
      }

      final board = await createBoardUseCase.execute(title, content, userToken);
      boards.insert(0, board); // 새 게시물을 목록에 추가 (선두에 추가)
      message = '게시물이 성공적으로 생성되었습니다.';
    } catch (e) {
      message = '게시물 생성에 실패했습니다.';
    }

    isLoading = false;
    notifyListeners();
  }
}
