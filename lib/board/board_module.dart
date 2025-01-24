// import 'package:flutter/material.dart';
// import 'package:flutter_ddd_test/board/presentation/providers/board_read_providers.dart';
// import 'package:flutter_ddd_test/board/presentation/ui/board_modify_page.dart';
// import 'package:provider/provider.dart';
// import 'package:provider/single_child_widget.dart';
// import '../config/base_url_provider.dart';
// import 'domain/usecases/create_board_usecase_impl.dart';
// import 'domain/usecases/read_board_usecase_impl.dart'; // 추가
// import 'domain/usecases/list_boards_usecase_impl.dart';
// import 'domain/usecases/update_board_usecase_impl.dart';
// import 'presentation/ui/board_create_page.dart';
// import 'presentation/ui/board_read_page.dart';
// import 'presentation/ui/board_list_page.dart';
// import 'infrastructure/data_sources/board_remote_data_source.dart';
// import 'infrastructure/repository/board_repository_impl.dart';
// import 'presentation/providers/board_providers.dart';
//
// class BoardModule {
//   // 공통 Providers 설정 메서드
//   static List<SingleChildWidget> _provideCommonProviders() {
//     return [
//       ChangeNotifierProvider<BaseUrlProvider>(
//         create: (_) => BaseUrlProvider(),
//       ),
//       ProxyProvider<BaseUrlProvider, BoardRemoteDataSource>(
//         update: (_, baseUrlProvider, __) =>
//             BoardRemoteDataSource(baseUrlProvider.baseUrl),
//       ),
//       ProxyProvider<BoardRemoteDataSource, BoardRepositoryImpl>(
//         update: (_, remoteDataSource, __) =>
//             BoardRepositoryImpl(remoteDataSource),
//       ),
//       ProxyProvider<BoardRepositoryImpl, ListBoardsUseCaseImpl>(
//         update: (_, repository, __) => ListBoardsUseCaseImpl(repository),
//       ),
//       ProxyProvider<BoardRepositoryImpl, CreateBoardUseCaseImpl>(
//         update: (_, repository, __) => CreateBoardUseCaseImpl(repository),
//       ),
//       ProxyProvider<BoardRepositoryImpl, ReadBoardUseCaseImpl>(
//         update: (_, repository, __) => ReadBoardUseCaseImpl(repository),
//       ),
//       ProxyProvider<BoardRepositoryImpl, UpdateBoardUseCaseImpl>(
//         update: (_, repository, __) => UpdateBoardUseCaseImpl(repository),
//       ),
//     ];
//   }
//
//   // BoardListPage 제공
//   static Widget provideBoardListPage() {
//     return MultiProvider(
//       providers: [
//         ..._provideCommonProviders(),
//         ChangeNotifierProvider<BoardProvider>(
//           create: (context) => BoardProvider(
//             listBoardsUseCase: context.read<ListBoardsUseCaseImpl>(),
//             createBoardUseCase: context.read<CreateBoardUseCaseImpl>(),
//             readBoardUseCase: context.read<ReadBoardUseCaseImpl>(),
//             updateBoardUseCase: context.read<UpdateBoardUseCaseImpl>(),
//           ),
//         ),
//       ],
//       child: BoardListPage(),
//     );
//   }
//
//   // BoardCreatePage 제공
//   static Widget provideBoardCreatePage() {
//     return MultiProvider(
//       providers: [
//         ..._provideCommonProviders(),
//         ChangeNotifierProvider<BoardProvider>(
//           create: (context) => BoardProvider(
//             listBoardsUseCase: context.read<ListBoardsUseCaseImpl>(),
//             createBoardUseCase: context.read<CreateBoardUseCaseImpl>(),
//             readBoardUseCase: context.read<ReadBoardUseCaseImpl>(),
//             updateBoardUseCase: context.read<UpdateBoardUseCaseImpl>(),
//           ),
//         ),
//       ],
//       child: BoardCreatePage(),
//     );
//   }
//
//   // BoardReadPage 제공
//   // static Widget provideBoardReadPage(int boardId) {
//   //   return MultiProvider(
//   //     providers: [
//   //       ..._provideCommonProviders(),
//   //       ChangeNotifierProvider<BoardProvider>(
//   //         create: (context) => BoardProvider(
//   //           listBoardsUseCase: context.read<ListBoardsUseCaseImpl>(),
//   //           createBoardUseCase: context.read<CreateBoardUseCaseImpl>(),
//   //           readBoardUseCase: context.read<ReadBoardUseCaseImpl>(),
//   //           updateBoardUseCase: context.read<UpdateBoardUseCaseImpl>(),
//   //         )..readBoard(boardId), // 게시글 읽기 로직
//   //       ),
//   //     ],
//   //     child: BoardReadPage(),
//   //   );
//   // }
//
//   static Widget provideBoardReadPage(int boardId) {
//     return MultiProvider(
//       providers: [
//         ..._provideCommonProviders(),
//         ChangeNotifierProvider<BoardReadProvider>(
//           create: (context) => BoardReadProvider(
//             readBoardUseCase: context.read<ReadBoardUseCaseImpl>(),
//           )..readBoard(boardId),  // 게시글 읽기
//         ),
//       ],
//       child: BoardReadPage(),
//     );
//   }
//
//   // BoardModifyPage 제공
//   static Widget provideBoardModifyPage(int boardId) {
//     return MultiProvider(
//       providers: [
//         ..._provideCommonProviders(),
//         ChangeNotifierProvider<BoardProvider>(
//           create: (context) => BoardProvider(
//             listBoardsUseCase: context.read<ListBoardsUseCaseImpl>(),
//             createBoardUseCase: context.read<CreateBoardUseCaseImpl>(),
//             readBoardUseCase: context.read<ReadBoardUseCaseImpl>(),
//             updateBoardUseCase: context.read<UpdateBoardUseCaseImpl>(),
//           )..readBoard(boardId), // 게시글 수정 로딩
//         ),
//       ],
//       child: BoardModifyPage(boardId: boardId),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_ddd_test/board/presentation/providers/board_create_providers.dart';
import 'package:flutter_ddd_test/board/presentation/providers/board_list_providers.dart';
import 'package:flutter_ddd_test/board/presentation/providers/board_modify_provider.dart';
import 'package:flutter_ddd_test/board/presentation/providers/board_read_providers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'domain/usecases/create_board_usecase_impl.dart';
import 'domain/usecases/read_board_usecase_impl.dart';
import 'domain/usecases/list_boards_usecase_impl.dart';
import 'domain/usecases/update_board_usecase_impl.dart';
import 'infrastructure/data_sources/board_remote_data_source.dart';
import 'infrastructure/repository/board_repository_impl.dart';
import 'presentation/providers/board_providers.dart';
import 'presentation/ui/board_create_page.dart';
import 'presentation/ui/board_list_page.dart';
import 'presentation/ui/board_read_page.dart';
import 'presentation/ui/board_modify_page.dart';

import 'package:flutter/material.dart';


class BoardModule {
  static final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  // Create an instance of BoardRemoteDataSource
  static final boardRemoteDataSource = BoardRemoteDataSource(baseUrl);

  // Create an instance of BoardRepositoryImpl with the remote data source
  static final boardRepository = BoardRepositoryImpl(boardRemoteDataSource);

  static final listBoardsUseCase = ListBoardsUseCaseImpl(boardRepository);
  static final createBoardUseCase = CreateBoardUseCaseImpl(boardRepository);
  static final readBoardUseCase = ReadBoardUseCaseImpl(boardRepository);
  static final updateBoardUseCase = UpdateBoardUseCaseImpl(boardRepository);

  // Common providers
  static List<SingleChildWidget> _provideCommonProviders() {
    return [
      // Pass boardRepository to the UseCase implementations
      Provider(create: (_) => listBoardsUseCase),
      Provider(create: (_) => createBoardUseCase),
      Provider(create: (_) => readBoardUseCase),
      Provider(create: (_) => updateBoardUseCase),
    ];
  }

  // BoardListPage provider
  static Widget provideBoardListPage() {
    return MultiProvider(
      providers: [
        ..._provideCommonProviders(),
        ChangeNotifierProvider(create: (_) => BoardListProvider(listBoardsUseCase: listBoardsUseCase)),
      ],
      child: BoardListPage(),
    );
  }

  // BoardCreatePage provider
  static Widget provideBoardCreatePage() {
    return MultiProvider(
      providers: [
        ..._provideCommonProviders(),
        ChangeNotifierProvider(
          create: (_) => BoardCreateProvider(createBoardUseCase: createBoardUseCase),
        ),
      ],
      child: BoardCreatePage(),
    );
  }

  // BoardReadPage provider
  static Widget provideBoardReadPage(int boardId) {
    return MultiProvider(
      providers: [
        ..._provideCommonProviders(),
        ChangeNotifierProvider(
          create: (_) => BoardReadProvider(
            readBoardUseCase: readBoardUseCase,
            boardId: boardId,
          )..fetchBoard(), // 데이터 로딩 시작
        ),
      ],
      child: BoardReadPage(),
    );
  }

  // BoardModifyPage provider
  static Widget provideBoardModifyPage(int boardId, String title, String content) {
    return MultiProvider(
      providers: [
        ..._provideCommonProviders(),
        ChangeNotifierProvider(
          create: (_) => BoardModifyProvider(
            updateBoardUseCase: updateBoardUseCase,
            boardId: boardId,
          ), // Load board data (if needed)
        ),
      ],
      child: BoardModifyPage(
        boardId: boardId, // Pass the boardId
        initialTitle: title, // Pass the initial title
        initialContent: content, // Pass the initial content
      ),
    );
  }
}