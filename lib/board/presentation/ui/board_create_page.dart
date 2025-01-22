import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/board_providers.dart'; // BoardProvider import

class BoardCreatePage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Board')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final content = contentController.text;

                print('Button pressed with title: $title and content: $content');

                // BoardProvider 사용
                try {
                  final provider = Provider.of<BoardProvider>(context, listen: false);
                  print('BoardProvider found: $provider');

                  provider.createBoard(title, content);
                  print('Board created successfully');
                } catch (e) {
                  print('Error while accessing BoardProvider: $e');
                }
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}