import 'package:flutter/material.dart';
import 'package:flutter_ddd_test/simple_chat/domain/usecases/send_simple_chat_usecase.dart';
import '../../domain/entity/simple_chat_message.dart';

class SimpleChatProvider extends ChangeNotifier {
  final SendSimpleChatUseCase sendSimpleChatUseCase;

  SimpleChatProvider({required this.sendSimpleChatUseCase});

  bool _isLoading = false;
  List<SimpleChatMessage> _messages = [];
  String? _userToken; // userToken 추가

  bool get isLoading => _isLoading;
  List<SimpleChatMessage> get messages => _messages;

  void setUserToken(String? token) {
    _userToken = token;
  }

  Future<void> sendMessage(String message, BuildContext context) async {
    if (_userToken == null || _userToken!.isEmpty) {
      // userToken이 없으면 로그인 메시지를 보여주고 로그인 페이지로 이동
      _showLoginPrompt(context);
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await sendSimpleChatUseCase.execute(message);
      _messages.add(SimpleChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: response, // content로 메시지 저장
        timestamp: DateTime.now(), // timestamp로 시간 저장
      ));
    } catch (e) {
      print("Error sending message: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addUserMessage(String message) {
    _messages.add(SimpleChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: message, // content 필드에 메시지 저장
      timestamp: DateTime.now(), // timestamp 필드에 시간 저장
    ));
    notifyListeners();
  }

  void _showLoginPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('로그인 필요'),
        content: Text('이 작업을 수행하려면 로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // 대화 상자 닫기
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 대화 상자 닫기
              Navigator.pushNamed(context, '/kakao-login'); // 로그인 페이지로 이동
            },
            child: Text('로그인'),
          ),
        ],
      ),
    );
  }
}
