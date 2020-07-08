import 'package:flutter/material.dart';
import 'package:maxcrowdfund/base/base_stateful_widget.dart';
import 'package:maxcrowdfund/components/text/text_view.dart';
import 'package:maxcrowdfund/screens/dashboard_screen.dart';
import 'package:maxcrowdfund/screens/login_screen.dart';
import 'package:maxcrowdfund/utilities/constant_variables.dart';
import 'package:maxcrowdfund/utilities/shared_preferences_helper.dart';
import 'package:maxcrowdfund/utilities/ui_constants.dart';

class SplashScreen extends BaseStatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> with BasicPage {
  final SharedPreferenceHelper _sharedPreferenceHelper =
      SharedPreferenceHelper();

  @override
  Widget getBody(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          elevation: 0,
          backgroundColor: kWhiteColor,
          brightness: Brightness.dark,
        ),
      ),
      body: Center(
        child: TextView(
          textAlign: TextAlign.center,
          text: 'MaxCrowd Fund',
          textColor: kBlackColor,
          fontFamily: kRegularStyle,
          fontSize: 40.0,
        ),
      ),
    );
  }

  @override
  bool onBackPress() {
    return true;
  }

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  _checkLogin() {
    Future.delayed(Duration(seconds: 3), () async {
      String token = await _sharedPreferenceHelper.get(kCsrfToken);
      if (token != null) {
        navigationService.pushReplacement(
          route: DashBoardScreen(),
        );
      } else {
        navigationService.pushReplacement(
          route: LoginScreen(),
        );
      }
    });
  }
}
