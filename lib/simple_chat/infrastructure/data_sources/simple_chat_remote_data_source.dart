import 'dart:convert';
import 'package:http/http.dart' as http;

class SimpleChatRemoteDataSource {
  final String apiUrl;
  final String apiKey;

  SimpleChatRemoteDataSource({required this.apiUrl, required this.apiKey});

  Future<String> fetchGeneratedText(String prompt) async {
    final url = Uri.parse(apiUrl);
    final headers = {'Authorization': 'Bearer $apiKey', 'Content-Type': 'application/json'};
    final body = {'inputs': prompt};

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['generated_text'] ?? ''; // Ensure 'generated_text' is returned
    } else {
      throw Exception('Failed to get response from LLM: ${response.statusCode}');
    }
  }
}
