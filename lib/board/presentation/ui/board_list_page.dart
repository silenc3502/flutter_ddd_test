import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/board_providers.dart';

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
    boardProvider.changePage(page);  // 페이지 변경
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Board List'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SafeArea(
        child: Consumer<BoardProvider>(
          builder: (context, boardProvider, child) {
            if (boardProvider.isLoading && boardProvider.boards.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            if (boardProvider.message.isNotEmpty) {
              return Center(child: Text(boardProvider.message));
            }

            // Ensure there are at least 6 items to fill the space
            List<dynamic> boards = List.from(boardProvider.boards);
            while (boards.length < 6) {
              boards.add(null);  // Add null or any placeholder to ensure 6 items
            }

            return Column(
              children: [
                // ListView section
                Expanded(  // Use Expanded to fill the available space dynamically
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: List.generate(boards.length, (index) {
                              final board = boards[index];
                              if (board == null) {
                                return SizedBox(height: 20);  // Placeholder for missing items
                              }
                              return Card(
                                elevation: 5,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        board.title,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                      Text(
                                        board.content,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            board.nickname.isEmpty ? '익명' : board.nickname,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            board.createDate,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Pagination section at the bottom
                if (boardProvider.totalPages > 0)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (boardProvider.currentPage > 1)
                          _buildPageButton('Prev', boardProvider.currentPage - 1),
                        ...List.generate(boardProvider.totalPages, (index) {
                          int pageNum = index + 1;
                          return _buildPageButton(
                            '$pageNum',
                            pageNum,
                            isCurrentPage: pageNum == boardProvider.currentPage,
                          );
                        }),
                        if (boardProvider.currentPage < boardProvider.totalPages)
                          _buildPageButton('Next', boardProvider.currentPage + 1),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPageButton(String label, int page, {bool isCurrentPage = false}) {
    return GestureDetector(
      onTap: () => _onPageChanged(page),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isCurrentPage ? Colors.deepPurple : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isCurrentPage ? Colors.white : Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
