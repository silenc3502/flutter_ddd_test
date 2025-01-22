import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/board_providers.dart'; // BoardProvider import

class BoardCreatePage extends StatefulWidget {
  @override
  _BoardCreatePageState createState() => _BoardCreatePageState();
}

class _BoardCreatePageState extends State<BoardCreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String _errorMessage = '';

  void _createBoard() async {
    final boardProvider = Provider.of<BoardProvider>(context, listen: false);
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      setState(() {
        _errorMessage = 'Title and content are required.';
      });
      return;
    }

    try {
      final response = await boardProvider.createBoard(title, content);
      if (true) {
        // Navigate back to board list page
        Navigator.pop(context);
      } else {
        setState(() {
          _errorMessage = 'Failed to create board post.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Board Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createBoard,
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
