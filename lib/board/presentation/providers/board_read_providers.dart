import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/usecases/delete_board_usecase.dart';
import '../../domain/usecases/read_board_usecase.dart';
import '../../domain/entity/board.dart';

class BoardReadProvider extends ChangeNotifier {
  final ReadBoardUseCase readBoardUseCase;
  final DeleteBoardUseCase deleteBoardUseCase;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  final int boardId;

  Board? _board;
  String? _error;
  bool _isLoading = false;

  BoardReadProvider(
      {required this.readBoardUseCase,
      required this.deleteBoardUseCase,
      required this.boardId});

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

  void updateBoard(Board updatedBoard) {
    if (_board?.id == updatedBoard.id) {
      print("read provider update");
      _board = updatedBoard;
      notifyListeners();
    }
  }

  Future<void> deleteBoard() async {
    try {
      if (board != null) {
        // Get the user token from FlutterSecureStorage
        final userToken = await _secureStorage.read(key: 'userToken');
        if (userToken == null) {
          throw Exception('User is not logged in.');
        }

        // Pass the boardId and userToken to the deleteBoardUseCase
        await deleteBoardUseCase.execute(board!.id, userToken);

        // Optionally, handle additional steps after deletion (e.g., notify listeners, update UI)
        _board = null; // Clear the board from memory after deletion
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      throw e;
    }
  }
}
