import 'package:flutter/foundation.dart';
import '../../domain/usecases/read_board_usecase.dart';
import '../../domain/entity/board.dart';

class BoardReadProvider extends ChangeNotifier {
  final ReadBoardUseCase readBoardUseCase;
  final int boardId;

  Board? _board;
  String? _error;
  bool _isLoading = false;

  BoardReadProvider({required this.readBoardUseCase, required this.boardId});

  Board? get board => _board;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> fetchBoard() async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _board = await readBoardUseCase.execute(boardId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteBoard() async {
    // try {
    //   if (board != null) {
    //     await readBoardUseCase.delete(board!.id); // UseCase에 삭제 로직 포함
    //   }
    // } catch (e) {
    //   errorMessage = '게시글 삭제 실패: $e';
    //   notifyListeners();
    //   throw e;
    // }
  }
}
