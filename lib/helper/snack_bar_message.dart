import 'package:flutter/material.dart';

void SnackBarMessage(BuildContext context, String message, Color backColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backColor,
    ),
  );
}
