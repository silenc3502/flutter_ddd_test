import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/responses/board_list_response.dart';
import '../../domain/entity/board.dart';

class BoardRemoteDataSource {
  final String baseUrl;

  BoardRemoteDataSource(this.baseUrl);

  Future<BoardListResponse> listBoards(int page, int perPage) async {
    print(
        'Requesting boards from: $baseUrl/board/list?page=$page&perPage=$perPage');

    final response = await http
        .get(Uri.parse('$baseUrl/board/list?page=$page&perPage=$perPage'));

    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Response data: $data');

      List<Board> boards = (data['dataList'] as List)
          .map((item) => Board(
                id: item['boardId'] ?? 0, // boardId 사용
                title: item['title'] ?? 'Untitled', // 제목 없으면 'Untitled'
                content: '', // content 없음, 빈 문자열
                nickname:
                    item['nickname'] ?? 'Anonymous', // 닉네임 없으면 'Anonymous'
                createDate:
                    item['createDate'] ?? 'Unknown', // createDate 없음, 'Unknown'
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

  Future<Board> createBoard(
      String title, String content, String userToken) async {
    print(
        '[BoardRemoteDataSource] Sending request to create board with title: $title, content: $content, userToken: $userToken');
    final url = Uri.parse('$baseUrl/board/create');
    final response = await http.post(url, body: {
      'title': title,
      'content': content,
      'userToken': userToken,
    });

    print('[BoardRemoteDataSource] Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('[BoardRemoteDataSource] Board created: $data');

      // Null 처리 및 기본값 설정
      return Board(
        id: data['data']['boardId'] ?? 0, // null일 경우 0으로 처리
        title: data['data']['title'] ?? 'Untitled', // null일 경우 기본값 설정
        content: data['data']['content'] ?? '',
        nickname:
            data['data']['writerNickname'] ?? 'Anonymous', // null일 경우 기본값 설정
        createDate: data['data']['createDate'] ?? 'Unknown', // null일 경우 기본값 설정
      );
    } else {
      print('[BoardRemoteDataSource] Error: Failed to create board');
      throw Exception('Failed to create board');
    }
  }

  Future<Board?> fetchBoard(int boardId) async {
    try {
      print('Fetching board with ID: $boardId');  // 요청하는 boardId 출력
      final response = await http.get(Uri.parse('$baseUrl/board/read/$boardId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Board data fetched successfully: $data');  // 성공적인 응답 출력
        return Board.fromJson(data);
      } else {
        print('Failed to load board: ${response.statusCode}');  // 실패 시 상태 코드 출력
        return null;
      }
    } catch (e) {
      print('Error fetching board: $e');  // 예외 발생 시 출력
      return null;
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
