import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class ReusableBorder {
  InputBorder getOutlineBorder({color: Color, width: double}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  InputBorder getOutlineBorderWithCornerRadius(
      {color: Color, width: double, double radius}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(radius.h),
      ),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  InputBorder getUnderlineBorder({color: Color, width: double}) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }
}
