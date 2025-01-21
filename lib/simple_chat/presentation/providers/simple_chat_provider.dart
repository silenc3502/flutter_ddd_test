import 'package:flutter/material.dart';
import '../../domain/usecases/send_simple_chat_usecase_impl.dart';

class SimpleChatProvider with ChangeNotifier {
  SendSimpleChatUseCaseImpl sendSimpleChatUseCase;

  SimpleChatProvider({required this.sendSimpleChatUseCase});

  void updateUseCase(SendSimpleChatUseCaseImpl newUseCase) {
    sendSimpleChatUseCase = newUseCase;
    notifyListeners();
  }

  Future<String> sendMessage(String message) async {
    final response = await sendSimpleChatUseCase.execute(message);
    notifyListeners();
    return response;
  }
}
