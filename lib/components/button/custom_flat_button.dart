import 'package:maxcrowdfund/components/text/text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class CustomFlatButton extends StatelessWidget {
  final double height;
  final double width;
  final double cornerRadius;
  final double titleSize;
  final Color backgroundColor;
  final Color textColor;
  final Function onPressed;
  final String title;
  final String fontFamily;

  CustomFlatButton({
    @required this.backgroundColor,
    @required this.onPressed,
    @required this.textColor,
    @required this.cornerRadius,
    @required this.title,
    @required this.fontFamily,
    @required this.titleSize,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        buttonTheme: _getStyle(context: context),
      ),
      child: RaisedButtonResponsive(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            cornerRadius,
          ),
        ),
        elevation: 0,
        color: backgroundColor,
        child: TextView(
          textColor: textColor,
          text: title,
          fontFamily: fontFamily,
          fontSize: titleSize,
        ),
      ),
    );
  }

  _getStyle({@required BuildContext context}) {
    ButtonThemeData buttonThemeData = Theme.of(context).buttonTheme;
    if (height != null) {
      buttonThemeData = buttonThemeData.copyWith(height: height);
    }
    if (width != null) {
      buttonThemeData = buttonThemeData.copyWith(minWidth: width);
    }
    return buttonThemeData;
  }
}
