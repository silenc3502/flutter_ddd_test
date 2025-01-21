import 'package:flutter_ddd_test/simple_chat/domain/usecases/send_simple_chat_usecase.dart';
import 'package:flutter_ddd_test/simple_chat/infrastructure/repository/simple_chat_repository.dart';

class SendSimpleChatUseCaseImpl implements SendSimpleChatUseCase {
  final SimpleChatRepository repository;

  SendSimpleChatUseCaseImpl(this.repository);

  @override
  Future<String> execute(String message) {
    return repository.sendMessage(message);
  }
}
