import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/board_providers.dart';

class BoardListPage extends StatelessWidget {
  const BoardListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.message.isNotEmpty) {
          return Center(child: Text(provider.message));
        }

        if (provider.boards.isEmpty) {
          return const Center(child: Text('등록된 내용이 없습니다'));
        }

        return ListView.builder(
          itemCount: provider.boards.length,
          itemBuilder: (context, index) {
            final board = provider.boards[index];
            return ListTile(
              title: Text(board.title),
              subtitle: Text(board.content),
            );
          },
        );
      },
    );
  }
}
