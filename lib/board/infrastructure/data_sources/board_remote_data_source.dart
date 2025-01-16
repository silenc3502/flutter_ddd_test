import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/responses/board_list_response.dart';
import '../../domain/entity/board.dart';

class BoardRemoteDataSource {
  final String baseUrl;

  BoardRemoteDataSource(this.baseUrl);

  Future<BoardListResponse> listBoards(int page, int perPage) async {
    print('Requesting boards from: $baseUrl/board/list?page=$page&perPage=$perPage');

    final response = await http.get(Uri.parse('$baseUrl/board/list?page=$page&perPage=$perPage'));

    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Response data: $data');

      List<Board> boards = (data['dataList'] as List)
          .map((item) => Board(
        id: item['boardId'] ?? 0, // boardId 사용
        title: item['title'] ?? 'Untitled', // 제목 없으면 'Untitled'
        content: '', // content 없음, 빈 문자열
        nickname: item['nickname'] ?? 'Anonymous', // 닉네임 없으면 'Anonymous'
        createDate: item['createDate'] ?? 'Unknown', // createDate 없음, 'Unknown'
      ))
          .toList();

      // totalItems와 totalPages를 int로 변환
      int totalItems = _parseInt(data['totalItems']);
      int totalPages = _parseInt(data['totalPages']);

      return BoardListResponse(
        boards: boards,
        totalItems: totalItems,
        totalPages: totalPages,
      );
    } else {
      print('Error: Failed to fetch boards');
      throw Exception('Failed to fetch boards');
    }
  }

  // String을 int로 변환하는 안전한 함수
  int _parseInt(dynamic value) {
    if (value is String) {
      return int.tryParse(value) ?? 0; // 변환 실패 시 기본값 0
    }
    return value ?? 0; // null 또는 int인 경우 그대로 반환
  }
}
