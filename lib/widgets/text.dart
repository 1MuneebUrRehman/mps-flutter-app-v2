import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  final String title;
  final double? fontSize;
  final Color? color;
  const TextWidget(
      {Key? key,
      required this.title,
      required this.fontSize,
      required this.color})
      : super(key: key);

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: widget.fontSize,
        color: widget.color,
      ),
      textAlign: TextAlign.center,
    );
  }
}
