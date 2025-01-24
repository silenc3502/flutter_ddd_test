import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common_ui/error_message.dart';
import '../../../common_ui/loading_indicator.dart';
import '../../../common_ui/custom_app_bar.dart'; // CustomAppBar import
import '../../board_module.dart';
import '../providers/board_list_providers.dart';
import 'component/page_content.dart';
import 'board_create_page.dart'; // 게시글 작성 페이지 import

class BoardListPage extends StatefulWidget {
  @override
  _BoardListPageState createState() => _BoardListPageState();
}

class _BoardListPageState extends State<BoardListPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // WidgetsBinding을 사용하여 build가 완료된 후 게시글을 불러옵니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final boardListProvider =
          Provider.of<BoardListProvider>(context, listen: false);
      boardListProvider.listBoards(1, 6); // 처음에 목록을 불러옴
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 페이지를 클릭했을 때 호출되는 함수
  void _onPageChanged(int page) {
    final boardListProvider =
        Provider.of<BoardListProvider>(context, listen: false);
    boardListProvider.listBoards(page, 6); // Load boards for the selected page
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = kToolbarHeight; // AppBar 기본 높이
    final double statusBarHeight =
        MediaQuery.of(context).padding.top; // 상태 표시줄 높이
    final double contentTopPadding = appBarHeight; // 간격 계산

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          body: Container(), // CustomAppBar의 body는 비워둠 (Scaffold body 사용)
          title: 'Board',
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // 리스트 콘텐츠
            Padding(
              padding: EdgeInsets.only(top: contentTopPadding), // 동적으로 계산된 간격
              child: Consumer<BoardListProvider>(
                builder: (context, boardListProvider, child) {
                  if (boardListProvider.isLoading &&
                      boardListProvider.boards.isEmpty) {
                    return LoadingIndicator(); // 공통 UI 사용
                  }

                  if (boardListProvider.message.isNotEmpty) {
                    return ErrorMessage(
                        message: boardListProvider.message); // 공통 UI 사용
                  }

                  return PageContent(
                    boardListProvider: boardListProvider,
                    onPageChanged: _onPageChanged, // 페이지 변경 핸들러 전달
                  );
                },
              ),
            ),
            // FloatingActionButton
            Positioned(
              top: statusBarHeight / 2,
              right: 16, // 오른쪽 여백
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BoardModule.provideBoardCreatePage(),
                    ),
                  ).then((_) {
                    // 게시글 작성 후 돌아오면 목록 갱신
                    final boardListProvider =
                        Provider.of<BoardListProvider>(context, listen: false);
                    boardListProvider.listBoards(1, 6); // 목록을 다시 불러옴
                  });
                },
                child: Icon(Icons.add),
                tooltip: 'Create Board',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
