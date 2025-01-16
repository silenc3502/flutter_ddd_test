import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'board/board_module.dart';

void main() async {
  // .env 파일 로드
  await dotenv.load();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: BoardModule.provideBoardListPage(), // BoardModule을 통해 의존성 주입된 페이지 제공
    );
  }
}
