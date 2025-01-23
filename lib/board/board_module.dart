import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/base_url_provider.dart';
import 'domain/usecases/create_board_usecase_impl.dart';
import 'domain/usecases/read_board_usecase_impl.dart';  // 추가
import 'domain/usecases/list_boards_usecase_impl.dart';
import 'presentation/ui/board_create_page.dart';
import 'presentation/ui/board_read_page.dart';
import 'presentation/ui/board_list_page.dart';
import 'infrastructure/data_sources/board_remote_data_source.dart';
import 'infrastructure/repository/board_repository_impl.dart';
import 'presentation/providers/board_providers.dart';

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
        ProxyProvider<BoardRepositoryImpl, CreateBoardUseCaseImpl>(
          update: (_, repository, __) => CreateBoardUseCaseImpl(repository),
        ),
        ProxyProvider<BoardRepositoryImpl, ReadBoardUseCaseImpl>(  // 추가
          update: (_, repository, __) => ReadBoardUseCaseImpl(repository),
        ),
        ChangeNotifierProvider<BoardProvider>(
          create: (context) => BoardProvider(
            listBoardsUseCase: context.read<ListBoardsUseCaseImpl>(),
            createBoardUseCase: context.read<CreateBoardUseCaseImpl>(),
            readBoardUseCase: context.read<ReadBoardUseCaseImpl>(),  // 직접 전달
          ),
        ),
      ],
      child: BoardListPage(),
    );
  }

  static Widget provideBoardCreatePage() {
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
        ProxyProvider<BoardRepositoryImpl, CreateBoardUseCaseImpl>(
          update: (_, repository, __) => CreateBoardUseCaseImpl(repository),
        ),
        ChangeNotifierProvider<BoardProvider>(
          create: (context) => BoardProvider(
            listBoardsUseCase: context.read<ListBoardsUseCaseImpl>(),
            createBoardUseCase: context.read<CreateBoardUseCaseImpl>(),
            readBoardUseCase: context.read<ReadBoardUseCaseImpl>(),  // 직접 전달
          ),
        ),
      ],
      child: BoardCreatePage(),
    );
  }

  static Widget provideBoardReadPage(int boardId) {
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
        ProxyProvider<BoardRepositoryImpl, ReadBoardUseCaseImpl>(
          update: (_, repository, __) => ReadBoardUseCaseImpl(repository),
        ),
        ProxyProvider<BoardRepositoryImpl, ListBoardsUseCaseImpl>(
          update: (_, repository, __) => ListBoardsUseCaseImpl(repository),
        ),
        ProxyProvider<BoardRepositoryImpl, CreateBoardUseCaseImpl>(
          update: (_, repository, __) => CreateBoardUseCaseImpl(repository),
        ),
      ],
      child: Builder(
        builder: (context) {
          return ChangeNotifierProvider<BoardProvider>(
            create: (_) => BoardProvider(
              listBoardsUseCase: context.read<ListBoardsUseCaseImpl>(),
              createBoardUseCase: context.read<CreateBoardUseCaseImpl>(),
              readBoardUseCase: context.read<ReadBoardUseCaseImpl>(),
            )..readBoard(boardId),
            child: BoardReadPage(),
          );
        },
      ),
    );
  }
}
