import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class TextFieldStyle {
  static TextStyle getStyle({
    @required Color textColor,
    double lineHeight,
    @required double fontSize,
    TextDecoration textDecoration,
    @required String fontFamily,
  }) {
    TextStyle textStyle = TextStyle();

    if (textColor != null) {
      textStyle = textStyle.copyWith(
        color: textColor,
      );
    }

    if (fontSize != null) {
      textStyle = textStyle.copyWith(
        fontSize: fontSize.sp,
      );
    }

    if (lineHeight != null) {
      textStyle = textStyle.copyWith(
        height: lineHeight,
      );
    }

    if (textDecoration != null) {
      textStyle = textStyle.copyWith(
        decoration: textDecoration,
      );
    }

    if (fontFamily != null) {
      textStyle = textStyle.copyWith(
        fontFamily: fontFamily,
      );
    }

    return textStyle;
  }
}
