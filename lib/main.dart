import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'board/presentation/ui/board_list_page.dart';
import 'config/base_url_provider.dart';

void main() async {
  await dotenv.load(); // .env 파일 로드

  runApp(
    ChangeNotifierProvider(
      create: (context) => BaseUrlProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: BoardListPage(), // 시작 화면 설정
    );
  }
}
