import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppText extends StatelessWidget {
  final String text;

  final Color? textColor;
  final TextStyle? style;
  final int? maxLines;
  final TextAlign textAlign;
  final TextDecoration? textDecoration;

  const AppText(
    this.text, {
    super.key,
    this.textColor,
    this.maxLines,
    this.textAlign = TextAlign.left,
    this.textDecoration,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: maxLines == null ? TextOverflow.visible : TextOverflow.ellipsis,
      style: style,
    );
  }
}
