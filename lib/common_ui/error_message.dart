// common_ui/error_message.dart
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;

  ErrorMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
