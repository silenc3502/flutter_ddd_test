import 'package:flutter/material.dart';
import 'package:flutter_ddd_test/board/presentation/ui/board_modify_page.dart';
import 'package:provider/provider.dart';
import '../config/base_url_provider.dart';
import 'domain/usecases/create_board_usecase_impl.dart';
import 'domain/usecases/read_board_usecase_impl.dart'; // 추가
import 'domain/usecases/list_boards_usecase_impl.dart';
import 'domain/usecases/update_board_usecase_impl.dart';
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
        ProxyProvider<BoardRepositoryImpl, ReadBoardUseCaseImpl>(
          // 추가
          update: (_, repository, __) => ReadBoardUseCaseImpl(repository),
        ),
        ProxyProvider<BoardRepositoryImpl, UpdateBoardUseCaseImpl>(
          update: (_, repository, __) => UpdateBoardUseCaseImpl(repository),
        ),
        ChangeNotifierProvider<BoardProvider>(
          create: (context) => BoardProvider(
            listBoardsUseCase: context.read<ListBoardsUseCaseImpl>(),
            createBoardUseCase: context.read<CreateBoardUseCaseImpl>(),
            readBoardUseCase: context.read<ReadBoardUseCaseImpl>(),
            updateBoardUseCase: context.read<UpdateBoardUseCaseImpl>(),
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
            readBoardUseCase: context.read<ReadBoardUseCaseImpl>(),
            updateBoardUseCase: context.read<UpdateBoardUseCaseImpl>(),
          ),
        ),
        ProxyProvider<BoardRepositoryImpl, UpdateBoardUseCaseImpl>(
          update: (_, repository, __) => UpdateBoardUseCaseImpl(repository),
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
        ProxyProvider<BoardRepositoryImpl, UpdateBoardUseCaseImpl>(
          update: (_, repository, __) => UpdateBoardUseCaseImpl(repository),
        ),
      ],
      child: Builder(
        builder: (context) {
          return ChangeNotifierProvider<BoardProvider>(
            create: (_) => BoardProvider(
              listBoardsUseCase: context.read<ListBoardsUseCaseImpl>(),
              createBoardUseCase: context.read<CreateBoardUseCaseImpl>(),
              readBoardUseCase: context.read<ReadBoardUseCaseImpl>(),
              updateBoardUseCase: context.read<UpdateBoardUseCaseImpl>(),
            )..readBoard(boardId),
            child: BoardReadPage(),
          );
        },
      ),
    );
  }

  static Widget provideBoardModifyPage(int boardId) {
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
        ProxyProvider<BoardRepositoryImpl, UpdateBoardUseCaseImpl>(
          update: (_, repository, __) => UpdateBoardUseCaseImpl(repository),
        ),
      ],
      child: Builder(
        builder: (context) {
          return ChangeNotifierProvider<BoardProvider>(
            create: (_) => BoardProvider(
              listBoardsUseCase: context.read<ListBoardsUseCaseImpl>(),
              createBoardUseCase: context.read<CreateBoardUseCaseImpl>(),
              readBoardUseCase: context.read<ReadBoardUseCaseImpl>(),
              updateBoardUseCase: context.read<UpdateBoardUseCaseImpl>(),
            )..readBoard(boardId), // 로딩이나 초기화할 작업 수행
            child: BoardModifyPage(boardId: boardId), // BoardModifyPage로 이동
          );
        },
      ),
    );
  }
}
