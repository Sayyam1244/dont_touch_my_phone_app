import 'package:flutter/material.dart';

class Apptext extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxLine;

  const Apptext(
      {super.key,
      required this.text,
      required this.style,
      this.overflow,
      this.textAlign,
      this.maxLine});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      textScaleFactor: 1,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: style,
    );
  }
}
