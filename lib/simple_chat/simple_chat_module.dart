import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/simple_chat_provider.dart';
import 'domain/usecases/send_simple_chat_usecase_impl.dart';
import 'infrastructure/repository/simple_chat_repository_impl.dart';
import 'infrastructure/data_sources/simple_chat_remote_data_source.dart';
import 'presentation/ui/simple_chat_page.dart';

class SimpleChatModule {
  static Widget provideSimpleChatPage(String apiUrl, String apiKey) {
    return MultiProvider(
      providers: [
        Provider<SimpleChatRemoteDataSource>(
          create: (_) =>
              SimpleChatRemoteDataSource(apiUrl: apiUrl, apiKey: apiKey),
        ),
        ProxyProvider<SimpleChatRemoteDataSource, SimpleChatRepositoryImpl>(
          update: (_, remoteDataSource, __) =>
              SimpleChatRepositoryImpl(remoteDataSource),
        ),
        ProxyProvider<SimpleChatRepositoryImpl, SendSimpleChatUseCaseImpl>(
          update: (_, repository, __) => SendSimpleChatUseCaseImpl(repository),
        ),
        ChangeNotifierProxyProvider<SendSimpleChatUseCaseImpl,
            SimpleChatProvider>(
          create: (context) => SimpleChatProvider(
            sendSimpleChatUseCase: context.read<SendSimpleChatUseCaseImpl>(),
          ),
          update: (_, useCase, previousProvider) {
            previousProvider?.updateUseCase(useCase);
            return previousProvider ??
                SimpleChatProvider(sendSimpleChatUseCase: useCase);
          },
        ),
      ],
      child: SimpleChatPage(),
    );
  }
}
