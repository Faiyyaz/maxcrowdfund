import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class CustomIconButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final double size;
  final Color color;

  CustomIconButton({
    @required this.onPressed,
    @required this.icon,
    @required this.size,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: size.h,
        color: color,
      ),
    );
  }
}
