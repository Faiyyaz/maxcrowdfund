import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maxcrowdfund/components/text/text_view.dart';
import 'package:maxcrowdfund/service/locator.dart';
import 'package:maxcrowdfund/service/navigation_service.dart';
import 'package:maxcrowdfund/utilities/constant_variables.dart';
import 'package:maxcrowdfund/utilities/ui_constants.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  BaseStatefulWidget({Key key}) : super(key: key);
}

abstract class BaseState<Page extends BaseStatefulWidget> extends State<Page> {}

mixin BasicPage<Page extends BaseStatefulWidget> on BaseState<Page> {
  bool _isShowing = false;
  Color _color;
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

  void showSnackBar({
    @required String message,
    @required String type,
  }) {
    switch (type) {
      case kSuccess:
        _color = kSuccessColor;
        break;
      case kError:
        _color = kErrorColor;
        break;
      case kInfo:
        _color = kInfoColor;
        break;
    }

    if (!_isShowing) {
      _isShowing = true;
      showFlash(
        context: context,
        duration: Duration(seconds: 3),
        builder: (context, controller) {
          return Flash(
            backgroundColor: _color,
            controller: controller,
            style: FlashStyle.grounded,
            child: FlashBar(
              message: TextView(
                text: message,
                textColor: kWhiteColor,
                fontSize: 16.0,
                fontFamily: kRegularStyle,
              ),
            ),
          );
        },
      ).whenComplete(() {
        _isShowing = false;
      });
    }
  }

  void showClickSnackBar({
    @required String message,
    String actionLabel = kOK,
    @required String type,
    @required Function onClick,
  }) {
    switch (type) {
      case kSuccess:
        _color = kSuccessColor;
        break;
      case kError:
        _color = kErrorColor;
        break;
      case kInfo:
        _color = kInfoColor;
        break;
    }

    if (!_isShowing) {
      _isShowing = true;
      showFlash(
        context: context,
        duration: Duration(seconds: 3),
        builder: (context, controller) {
          return Flash(
            backgroundColor: _color,
            controller: controller,
            style: FlashStyle.grounded,
            child: FlashBar(
              message: TextView(
                text: message,
                textColor: kWhiteColor,
                fontSize: 16.0,
                fontFamily: kRegularStyle,
              ),
              primaryAction: FlatButton(
                onPressed: () {
                  _isShowing = false;
                  controller.dismiss();
                },
                child: TextView(
                  text: actionLabel,
                  textColor: kWhiteColor,
                  fontSize: 16.0,
                  fontFamily: kRegularStyle,
                ),
              ),
            ),
          );
        },
      ).whenComplete(() {
        _isShowing = false;
        onClick();
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
