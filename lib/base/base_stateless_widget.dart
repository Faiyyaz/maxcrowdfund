import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maxcrowdfund/service/locator.dart';
import 'package:maxcrowdfund/service/navigation_service.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

abstract class BaseStatelessWidget extends StatelessWidget {
  BaseStatelessWidget({Key key}) : super(key: key);

  final NavigationService navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidgets.builder(
      height: 812,
      width: 375,
      allowFontScaling: false,
      child: getBody(context),
    );
  }

  Widget getBody(BuildContext context);

  bool onBackPress();
}
