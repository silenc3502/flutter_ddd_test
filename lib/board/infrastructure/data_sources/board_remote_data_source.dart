import 'dart:convert';
import 'package:http/http.dart' as http;

class BoardRemoteDataSource {
  final String baseUrl;

  BoardRemoteDataSource(this.baseUrl);

  Future<List<Map<String, dynamic>>> listBoards(int page, int perPage) async {
    print('Requesting boards from: $baseUrl/board/list?page=$page&perPage=$perPage');

    final response = await http.get(Uri.parse('$baseUrl/board/list?page=$page&perPage=$perPage'));

    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Response data: $data');
      return List<Map<String, dynamic>>.from(data['dataList']);
    } else {
      print('Error: Failed to fetch boards');
      throw Exception('Failed to fetch boards');
    }
  }
}
