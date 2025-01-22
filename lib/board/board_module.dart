import 'package:flutter/material.dart';
import 'package:flutter_ddd_test/board/presentation/ui/board_create_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../config/base_url_provider.dart';
import 'domain/usecases/create_board_usecase_impl.dart';
import 'presentation/ui/board_list_page.dart';
import 'presentation/providers/board_providers.dart';
import 'infrastructure/data_sources/board_remote_data_source.dart';
import 'domain/usecases/list_boards_usecase_impl.dart';
import 'infrastructure/repository/board_repository_impl.dart';

class BoardModule {
  static Widget provideBoardListPage() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseUrlProvider>(
          create: (_) => BaseUrlProvider(),
        ),
        ProxyProvider<BaseUrlProvider, BoardRemoteDataSource>(
          update: (_, baseUrlProvider, __) =>
              BoardRemoteDataSource(baseUrlProvider.baseUrl),
        ),
        ProxyProvider<BoardRemoteDataSource, BoardRepositoryImpl>(
          update: (_, remoteDataSource, __) =>
              BoardRepositoryImpl(remoteDataSource),
        ),
        ProxyProvider<BoardRepositoryImpl, ListBoardsUseCaseImpl>(
          update: (_, repository, __) => ListBoardsUseCaseImpl(repository),
        ),
        // CreateBoardUseCaseImpl을 먼저 추가합니다.
        ProxyProvider<BoardRepositoryImpl, CreateBoardUseCaseImpl>(
          update: (_, repository, __) => CreateBoardUseCaseImpl(repository),
        ),
        ChangeNotifierProvider<BoardProvider>(
          create: (context) => BoardProvider(
            listBoardsUseCase: context.read<ListBoardsUseCaseImpl>(),
            createBoardUseCase: context.read<CreateBoardUseCaseImpl>(),
          ),
        ),
      ],
      child: BoardListPage(),
    );
  }

  // Provides the BoardCreatePage with necessary dependencies
  static Widget provideBoardCreatePage() {
    return MultiProvider(
      providers: [
        // Add common dependencies here if needed, such as BaseUrlProvider, etc.
        ChangeNotifierProvider<BaseUrlProvider>(
          create: (_) => BaseUrlProvider(),
        ),
        ProxyProvider<BaseUrlProvider, BoardRemoteDataSource>(
          update: (_, baseUrlProvider, __) =>
              BoardRemoteDataSource(baseUrlProvider.baseUrl),
        ),
        ProxyProvider<BoardRemoteDataSource, BoardRepositoryImpl>(
          update: (_, remoteDataSource, __) =>
              BoardRepositoryImpl(remoteDataSource),
        ),
        ProxyProvider<BoardRepositoryImpl, ListBoardsUseCaseImpl>(
          update: (_, repository, __) => ListBoardsUseCaseImpl(repository),
        ),
        ProxyProvider<BoardRepositoryImpl, CreateBoardUseCaseImpl>(
          update: (_, repository, __) => CreateBoardUseCaseImpl(repository),
        ),
        // You can pass the same BoardProvider here, if needed
        ChangeNotifierProvider<BoardProvider>(
          create: (context) => BoardProvider(
            listBoardsUseCase: context.read<ListBoardsUseCaseImpl>(),
            createBoardUseCase: context.read<CreateBoardUseCaseImpl>(),
          ),
        ),
      ],
      child: BoardCreatePage(),  // The actual page you're navigating to
    );
  }
}

