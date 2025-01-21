import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/simple_chat_provider.dart';

class SimpleChatPage extends StatefulWidget {
  @override
  _SimpleChatPageState createState() => _SimpleChatPageState();
}

class _SimpleChatPageState extends State<SimpleChatPage> {
  final TextEditingController _messageController = TextEditingController();
  String? _response;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SimpleChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Enter your message',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final message = _messageController.text.trim();
                if (message.isNotEmpty) {
                  try {
                    final result = await provider.sendMessage(message);
                    setState(() {
                      _response = result;
                    });
                  } catch (e) {
                    setState(() {
                      _response = 'Error: $e';
                    });
                  }
                }
              },
              child: const Text('Send'),
            ),
            const SizedBox(height: 24),
            if (_response != null) ...[
              const Text(
                'Response:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(_response!),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
