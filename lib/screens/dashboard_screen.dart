import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maxcrowdfund/api/success/balance_response.dart';
import 'package:maxcrowdfund/api/web_functions.dart';
import 'package:maxcrowdfund/base/base_stateful_widget.dart';
import 'package:maxcrowdfund/components/button/custom_icon_button.dart';
import 'package:maxcrowdfund/components/dialog/loader.dart';
import 'package:maxcrowdfund/components/text/text_view.dart';
import 'package:maxcrowdfund/screens/login_screen.dart';
import 'package:maxcrowdfund/utilities/constant_variables.dart';
import 'package:maxcrowdfund/utilities/shared_preferences_helper.dart';
import 'package:maxcrowdfund/utilities/ui_constants.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class DashBoardScreen extends BaseStatefulWidget {
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends BaseState<DashBoardScreen> with BasicPage {
  final WebFunctions _webFunctions = WebFunctions();
  final SharedPreferenceHelper _sharedPreferenceHelper =
      SharedPreferenceHelper();
  Loader _loader;
  String _heading = '';
  Map<String, Datum> _balance;

  @override
  Widget getBody(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        brightness: Brightness.dark,
        title: TextView(
          textAlign: TextAlign.center,
          text: 'Dashboard',
          textColor: kBlackColor,
          fontFamily: kRegularStyle,
          fontSize: 20.0,
        ),
        actions: <Widget>[
          CustomIconButton(
            onPressed: () {
              _doLogout();
            },
            icon: Icons.exit_to_app,
            size: 20,
            color: kBlackColor,
          )
        ],
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsetsResponsive.symmetric(
          vertical: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextView(
              textAlign: TextAlign.center,
              text: _heading,
              textColor: kBlackColor,
              fontFamily: kRegularStyle,
              fontSize: 15.0,
            ),
            Expanded(
              child: _getListWidget(),
            ),
          ],
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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _loader = Loader(context: context);
      _callWebFunction();
    });
  }

  _callWebFunction() async {
    _loader.show();
    Response response = await _webFunctions.getBalance();
    if (response != null) {
      _loader.hide();
      Map<String, dynamic> res = jsonDecode(response.data);
      BalanceResponse balanceResponse = BalanceResponse.fromJson(res);
      if (balanceResponse.userLoginStatus == 0) {
        _webFunctions.deleteCookies();
        await _sharedPreferenceHelper.clear();
        showClickSnackBar(
            message: 'Your session has expired. Please relogin',
            type: kError,
            onClick: () {
              navigationService.pushReplacement(
                route: LoginScreen(),
              );
            });
      } else {
        if (balanceResponse.balance != null) {
          _balance = balanceResponse.balance.data;
          _heading = balanceResponse.balance.heading;
          setState(() {});
        }
      }
    } else {
      _loader.hide();
    }
  }

  _doLogout() async {
    _loader.show();
    String logoutToken = await _sharedPreferenceHelper.get(kLogoutToken);
    Response response = await _webFunctions.logout(logoutToken: logoutToken);
    if (response != null) {
      _loader.hide();
      await _sharedPreferenceHelper.clear();
      _webFunctions.deleteCookies();
      showClickSnackBar(
          message: 'Logout successfully',
          type: kSuccess,
          onClick: () {
            navigationService.pushReplacement(
              route: LoginScreen(),
            );
          });
    } else {
      _loader.hide();
    }
  }

  _getListWidget() {
    if (_balance == null) {
      return SizedBoxResponsive(
        height: 0,
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: _balance.length,
        itemBuilder: (BuildContext context, int index) {
          String key = _balance.keys.elementAt(index);
          return Container(
            margin: EdgeInsetsResponsive.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: TextView(
                    textColor: kBlackColor,
                    text: '${_balance[key].title}',
                    fontSize: 16.0,
                    fontFamily: kRegularStyle,
                  ),
                ),
                TextView(
                  textColor: kBlackColor,
                  text: '${_balance[key].value}',
                  fontSize: 16.0,
                  fontFamily: kRegularStyle,
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
