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

    print('API response status: ${response.statusCode}');
    print('API response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.isNotEmpty && data[0]['generated_text'] != null) {
        // print('Generated text from API: ${data[0]['generated_text']}');
        return data[0]['generated_text'];
      } else {
        throw Exception('Generated text is missing in the response');
      }
    } else {
      throw Exception('Failed to get response from LLM: ${response.statusCode}');
    }
  }
}
