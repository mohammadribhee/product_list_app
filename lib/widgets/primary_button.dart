import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? horizontal;
  final double? vertical;
  final double? shape;
  final double? fontSize;

  const PrimaryButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.backgroundColor,
      this.textColor,
      this.horizontal,
      this.vertical,
      this.shape,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.deepPurple,
        foregroundColor: textColor ?? Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: horizontal ?? 20, vertical: vertical ?? 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(shape ?? 8),
        ),
        elevation: 2,
      ),
      child: Text(label, style: TextStyle(fontSize: fontSize ?? 16)),
    );
  }
}
