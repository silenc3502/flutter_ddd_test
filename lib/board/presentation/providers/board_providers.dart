import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entity/board.dart';
import '../../domain/usecases/create_board_usecase.dart';
import '../../domain/usecases/list_boards_usecase.dart';
import '../../domain/usecases/read_board_usecase.dart';

class BoardProvider with ChangeNotifier {
  final ListBoardsUseCase listBoardsUseCase;
  final CreateBoardUseCase createBoardUseCase;
  final ReadBoardUseCase readBoardUseCase;

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  List<Board> boards = [];
  Board? selectedBoard;

  bool isLoading = false;
  bool isReading = false;

  String message = '';
  int totalItems = 0;
  int totalPages = 0;
  int currentPage = 1;

  BoardProvider({
    required this.listBoardsUseCase,
    required this.createBoardUseCase,
    required this.readBoardUseCase,
  }) {
    _initBoards();
  }

  Future<void> _initBoards() async {
    await listBoards(currentPage, 6); // 초기 페이지 로드
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
        totalPages = response.totalPages; // 서버에서 받아온 totalPages 사용
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
      await listBoards(page, 6); // 페이지 변경 시 해당 페이지 데이터를 요청
    }
  }

  // 게시물 생성 메소드 추가
  Future<void> createBoard(String title, String content) async {
    isLoading = true;
    notifyListeners();

    try {
      // userToken 읽기 시도
      final userToken = await _secureStorage.read(key: 'userToken');
      print('[createBoard] Retrieved userToken: $userToken');

      if (userToken == null) {
        message = '로그인 상태가 아닙니다. 먼저 로그인 해주세요.';
        isLoading = false;
        notifyListeners();
        return;
      }

      // 게시물 생성 UseCase 호출
      final board = await createBoardUseCase.execute(title, content, userToken);
      print('[createBoard] Board created successfully: $board');

      // 새 게시물을 목록에 추가
      boards.insert(0, board);
      message = '게시물이 성공적으로 생성되었습니다.';
    } catch (e) {
      print('[createBoard] Error: $e');
      message = '게시물 생성에 실패했습니다. 오류: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> readBoard(int boardId) async {
    try {
      print('Attempting to read board with ID: $boardId');  // boardId 출력

      isReading = true;
      print('Calling ReadBoardUseCase to fetch board...');
      selectedBoard = await readBoardUseCase.execute(boardId);
      notifyListeners();

      // 결과가 null인 경우에도 상태 출력
      if (selectedBoard == null) {
        print('No board found for ID: $boardId');
      } else {
        print('Board found: ${selectedBoard!.title}');
      }
    } catch (e) {
      print('Error reading board: $e');
      selectedBoard = null;
    } finally {
      isReading = false;
      notifyListeners();
      print('Reading complete. isReading: $isReading');
    }
  }

  void clearSelectedBoard() {
    selectedBoard = null;
    notifyListeners();
  }
}
