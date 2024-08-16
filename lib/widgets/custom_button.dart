import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.border,
    required this.onPressed,
    required this.width,
    required this.btnColor,
    required this.text,
  });
  final void Function()? onPressed;
  final double width;
  final Color btnColor;
  final String text;
  final BoxBorder? border;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: border,
        borderRadius: BorderRadius.circular(15),
        color: btnColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(text,
            style: const TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }
}
