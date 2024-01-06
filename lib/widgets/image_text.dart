import 'package:flutter/material.dart';


import 'package:photo_editor/models/text_info.dart';

class ImageText extends StatelessWidget {
  const ImageText({super.key, required this.textInfo});

  final TextInfo textInfo;

  @override
  Widget build(BuildContext context) {
    return Text(
      textInfo.text,
      style: TextStyle(
        color: textInfo.color,
        fontSize: textInfo.fontSize,
        fontWeight: textInfo.fontWeight,
        fontStyle: textInfo.fontStyle,
      ),
      textAlign: textInfo.textAlign,
    );
  }
}
    