import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class CustomIcon extends StatelessWidget {
  final IconData iconData;
  final double size;
  final Color color;

  CustomIcon({
    @required this.iconData,
    @required this.size,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      size: size.h,
      color: color,
    );
  }
}
