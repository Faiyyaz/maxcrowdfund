import 'package:maxcrowdfund/utilities/dialog_utils.dart';
import 'package:maxcrowdfund/utilities/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader {
  final BuildContext context;
  final bool showBackgroundColor;

  Loader({
    @required this.context,
    this.showBackgroundColor = true,
  });

  void show() {
    DialogUtils _dialogUtils = DialogUtils();
    _dialogUtils.showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SpinKitThreeBounce(
          color: kWhiteColor,
        ),
      ),
    );
  }

  void hide() {
    Navigator.pop(context);
  }
}
