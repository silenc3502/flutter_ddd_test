import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/entity/board.dart';
import '../data_sources/board_remote_data_source.dart';
import 'board_repository.dart';

class BoardRepositoryImpl implements BoardRepository {
  final BoardRemoteDataSource remoteDataSource;

  BoardRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Board>> listBoards(int page, int perPage) async {
    try {
      final data = await remoteDataSource.listBoards(page, perPage);
      return data.map((item) {
        return Board(
          id: item['id'],
          title: item['title'],
          content: item['content'],
          userId: item['userId'],
        );
      }).toList();
    } catch (e) {
      throw Exception('Error fetching boards: $e');
    }
  }
}
