import 'package:flutter/material.dart';
import '../../../board/board_module.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to BoardListPage provided by BoardModule
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BoardModule.provideBoardListPage(),
              ),
            );
          },
          child: Text('Go to Board List'),
        ),
      ),
    );
  }
}
