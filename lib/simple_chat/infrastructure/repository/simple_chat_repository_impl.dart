import 'package:flutter_ddd_test/simple_chat/infrastructure/repository/simple_chat_repository.dart';

import '../../domain/entity/simple_chat_message.dart';
import '../data_sources/simple_chat_remote_data_source.dart';

class SimpleChatRepositoryImpl implements SimpleChatRepository {
  final SimpleChatRemoteDataSource remoteDataSource;

  SimpleChatRepositoryImpl(this.remoteDataSource);

  // @override
  // Future<List<SimpleChatMessage>> fetchMessages() {
  //   return remoteDataSource.fetchMessages();
  // }

  @override
  Future<String> sendMessage(String message) async {
    try {
      final generatedText = await remoteDataSource.fetchGeneratedText(message);
      print('Generated response: $generatedText');
      return generatedText;
    } catch (e) {
      throw Exception("Failed to send message: $e");
    }
  }
}
