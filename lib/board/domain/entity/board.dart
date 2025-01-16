class Board {
  final int id;  // boardId는 String으로 처리
  final String title;
  final String content;
  final String nickname;
  final String createDate;

  Board({
    required this.id,
    required this.title,
    required this.content,
    required this.nickname,
    required this.createDate,
  });

  // JSON 데이터를 Board 객체로 변환
  factory Board.fromJson(Map<String, dynamic> json) {
    try {
      print('Parsing Board JSON: $json');

      return Board(
        id: json['boardId'],  // boardId는 int이므로 toString()으로 변환
        title: json['title'] ?? 'No Title',  // title 기본값 추가
        content: json['content'] ?? '', // 빈 값 대체
        nickname: json['nickname'] ?? '익명', // 닉네임 대체
        createDate: json['createDate'] ?? 'Unknown', // createDate 기본값 추가
      );
    } catch (e) {
      print('Error parsing Board JSON: $json, Error: $e');
      rethrow;
    }
  }
}
