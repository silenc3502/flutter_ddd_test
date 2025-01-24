import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // secure_storage import
import '../../domain/usecases/create_board_usecase.dart'; // CreateBoardUseCase import

class BoardCreateProvider with ChangeNotifier {
  final CreateBoardUseCase createBoardUseCase;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage(); // secure storage instance

  BoardCreateProvider({required this.createBoardUseCase});

  bool isLoading = false;
  String message = '';

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

      message = '게시물이 성공적으로 생성되었습니다.';
    } catch (e) {
      print('[createBoard] Error: $e');
      message = '게시물 생성에 실패했습니다. 오류: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
