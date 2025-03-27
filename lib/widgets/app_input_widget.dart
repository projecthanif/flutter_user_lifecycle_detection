import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInputWidget extends StatelessWidget {
  const AppInputWidget({
    super.key,
    required this.controller,
    this.hintText = '',
    this.labelText = '',
  });

  final TextEditingController controller;
  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
