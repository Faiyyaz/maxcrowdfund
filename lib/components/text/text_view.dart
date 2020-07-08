import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class TextView extends StatelessWidget {
  final String text;
  final Color textColor;
  final double lineHeight;
  final double fontSize;
  final int maxLines;
  final TextAlign textAlign;
  final String fontFamily;
  final TextDecoration textDecoration;
  final TextOverflow textOverflow;

  TextView({
    @required this.text,
    @required this.textColor,
    this.lineHeight,
    @required this.fontSize,
    this.textAlign = TextAlign.left,
    @required this.fontFamily,
    this.maxLines,
    this.textDecoration = TextDecoration.none,
    this.textOverflow = TextOverflow.clip,
  });

  @override
  Widget build(BuildContext context) {
    return TextResponsive(
      text,
      style: _getStyle(),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
    );
  }

  TextStyle _getStyle() {
    TextStyle textStyle = TextStyle();

    if (textColor != null) {
      textStyle = textStyle.copyWith(
        color: textColor,
      );
    }

    if (fontSize != null) {
      textStyle = textStyle.copyWith(
        fontSize: fontSize,
      );
    }

    if (lineHeight != null) {
      textStyle = textStyle.copyWith(
        height: lineHeight,
      );
    }

    if (fontFamily != null) {
      textStyle = textStyle.copyWith(
        fontFamily: fontFamily,
      );
    }

    if (textDecoration != null) {
      textStyle = textStyle.copyWith(
        decoration: textDecoration,
      );
    }

    return textStyle;
  }
}
