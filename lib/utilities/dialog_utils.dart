import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maxcrowdfund/utilities/ui_constants.dart';

class DialogUtils {
  Future<T> showDialog<T>({
    @required
        BuildContext context,
    bool barrierDismissible = true,
    DialogAnimation dialogAnimation = DialogAnimation.NORMAL,
    @Deprecated(
        'Instead of using the "child" argument, return the child from a closure '
        'provided to the "builder" argument. This will ensure that the BuildContext '
        'is appropriate for widgets built in the dialog.')
        Widget child,
    WidgetBuilder builder,
  }) {
    assert(child == null || builder == null);
    assert(debugCheckHasMaterialLocalizations(context));

    final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = child ?? Builder(builder: builder);
        return Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        });
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.7),
      transitionDuration: Duration(milliseconds: 200),
      transitionBuilder: _getAnimation(
        dialogAnimation: dialogAnimation,
      ),
    );
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }

  Widget _buildScaleDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return Transform.scale(
      scale: animation.value,
      child: Opacity(
        opacity: animation.value,
        child: child,
      ),
    );
  }

  Widget _buildSlideFromBottomTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    final curvedValue = Curves.easeInOutBack.transform(animation.value) - 1.0;
    return Transform(
      transform: Matrix4.translationValues(0.0, -(curvedValue * 200), 0.0),
      child: Opacity(
        opacity: animation.value,
        child: child,
      ),
    );
  }

  Widget _buildSlideFromTopTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    final curvedValue = Curves.easeInOutBack.transform(animation.value) - 1.0;
    return Transform(
      transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
      child: Opacity(
        opacity: animation.value,
        child: child,
      ),
    );
  }

  _getAnimation({DialogAnimation dialogAnimation}) {
    if (dialogAnimation == DialogAnimation.NORMAL) {
      return _buildMaterialDialogTransitions;
    } else if (dialogAnimation == DialogAnimation.SCALE) {
      return _buildScaleDialogTransitions;
    } else if (dialogAnimation == DialogAnimation.SLIDE_FROM_BOTTOM) {
      return _buildSlideFromBottomTransitions;
    } else {
      return _buildSlideFromTopTransitions;
    }
  }
}

enum DialogAnimation { NORMAL, SCALE, SLIDE_FROM_BOTTOM, SLIDE_FROM_TOP }
