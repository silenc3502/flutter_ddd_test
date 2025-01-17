import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common_ui/error_message.dart';
import '../../../common_ui/loading_indicator.dart';
import '../../../common_ui/app_bar_action.dart'; // 공통 UI import
import '../providers/board_providers.dart';
import 'component/page_content.dart';

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
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 페이지를 클릭했을 때 호출되는 함수
  void _onPageChanged(int page) {
    final boardProvider = Provider.of<BoardProvider>(context, listen: false);
    boardProvider.changePage(page); // 페이지 변경
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Board List'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          // 게시판 아이콘
          AppBarAction(
            icon: Icons.home,
            tooltip: 'Home',
            onPressed: () {
              Navigator.pop(context); // Home으로 이동
            },
          ),
          // 로그인 아이콘
          AppBarAction(
            icon: Icons.login,
            tooltip: 'Login',
            onPressed: () {
              // Login 페이지로 이동
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<BoardProvider>(
          builder: (context, boardProvider, child) {
            if (boardProvider.isLoading && boardProvider.boards.isEmpty) {
              return LoadingIndicator(); // 공통 UI 사용
            }

            if (boardProvider.message.isNotEmpty) {
              return ErrorMessage(message: boardProvider.message); // 공통 UI 사용
            }

            return PageContent(
              boardProvider: boardProvider,
              onPageChanged: _onPageChanged, // 페이지 변경 핸들러 전달
            );
          },
        ),
      ),
    );
  }
}
