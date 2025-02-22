import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String title;
  final String content;
  final String nickname;
  final String createDate;

  final VoidCallback? onTap; // 클릭 이벤트 콜백 추가

  CardItem({
    required this.title,
    required this.content,
    required this.nickname,
    required this.createDate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // 클릭 이벤트를 감지하는 래퍼
      onTap: onTap,
      child: Card(
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
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              Text(
                content,
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
                    nickname.isEmpty ? '익명' : nickname,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    createDate,
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
      ),
    );
  }
}
