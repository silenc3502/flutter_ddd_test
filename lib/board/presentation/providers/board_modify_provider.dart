import 'package:flutter/material.dart';
import '../../domain/entity/board.dart';
import '../../domain/usecases/update_board_usecase.dart';

class BoardModifyProvider extends ChangeNotifier {
  final UpdateBoardUseCase updateBoardUseCase;
  final int boardId;

  BoardModifyProvider({
    required this.updateBoardUseCase,
    required this.boardId,
  });

  Future<void> updateBoard(String title, String content, String userToken) async {
    try {
      await updateBoardUseCase.execute(boardId, title, content, userToken);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to update board: $e');
    }
  }
}
