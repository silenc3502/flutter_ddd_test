import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../config/base_url_provider.dart';

class BoardRemoteDataSource {
  final BuildContext context;

  BoardRemoteDataSource(this.context);

  Future<List<Map<String, dynamic>>> listBoards(int page, int perPage) async {
    // Base URL을 Provider에서 가져오기
    final String baseUrl =
        Provider.of<BaseUrlProvider>(context, listen: false).baseUrl;

    final response = await http
        .get(Uri.parse('$baseUrl/board/list?page=$page&perPage=$perPage'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(
          json.decode(response.body)['dataList']);
    } else {
      throw Exception('Failed to fetch boards');
    }
  }
}
