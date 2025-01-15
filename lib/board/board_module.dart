import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../config/base_url_provider.dart';
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
        Provider<BoardRemoteDataSource>(
          create: (context) => BoardRemoteDataSource(context),
        ),
        ProxyProvider<BoardRemoteDataSource, BoardRepositoryImpl>(
          update: (_, dataSource, __) => BoardRepositoryImpl(dataSource),
        ),
        ProxyProvider<BoardRepositoryImpl, ListBoardsUseCaseImpl>(
          update: (_, repository, __) => ListBoardsUseCaseImpl(repository),
        ),
        ChangeNotifierProvider<BoardProvider>(
          create: (context) => BoardProvider(
            listBoardsUseCase: context.read<ListBoardsUseCaseImpl>(),
          ),
        ),
      ],
      child: const BoardListPage(),
    );
  }
}
