import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maxcrowdfund/api/success/login_response.dart';
import 'package:maxcrowdfund/api/web_functions.dart';
import 'package:maxcrowdfund/base/base_stateful_widget.dart';
import 'package:maxcrowdfund/components/button/custom_button.dart';
import 'package:maxcrowdfund/components/dialog/loader.dart';
import 'package:maxcrowdfund/components/icon/custom_icon.dart';
import 'package:maxcrowdfund/components/text/text_view.dart';
import 'package:maxcrowdfund/components/textfield/text_field_style.dart';
import 'package:maxcrowdfund/screens/dashboard_screen.dart';
import 'package:maxcrowdfund/utilities/constant_variables.dart';
import 'package:maxcrowdfund/utilities/shared_preferences_helper.dart';
import 'package:maxcrowdfund/utilities/ui_constants.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class LoginScreen extends BaseStatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen> with BasicPage {
  final WebFunctions _webFunctions = WebFunctions();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SharedPreferenceHelper _sharedPreferenceHelper =
      SharedPreferenceHelper();

  bool _isPasswordVisible = false;
  Loader _loader;

  bool _isValidName = true;
  bool _isValidPassword = true;

  @override
  Widget getBody(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        brightness: Brightness.dark,
        title: TextView(
          textAlign: TextAlign.center,
          text: 'Login',
          textColor: kBlackColor,
          fontFamily: kRegularStyle,
          fontSize: 20.0,
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(
            FocusNode(),
          );
        },
        child: Container(
          margin: EdgeInsetsResponsive.symmetric(
            horizontal: 32.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                maxLines: 1,
                textInputAction: TextInputAction.done,
                controller: _nameController,
                autocorrect: false,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                  hintStyle: TextFieldStyle.getStyle(
                    textColor: kBlackColor,
                    fontSize: 16.0,
                    fontFamily: kRegularStyle,
                  ),
                  errorText: _isValidName ? null : 'Please enter name',
                  errorStyle: TextFieldStyle.getStyle(
                    textColor: kErrorColor,
                    fontSize: 16.0,
                    fontFamily: kRegularStyle,
                  ),
                ),
                style: TextFieldStyle.getStyle(
                  textColor: kBlackColor,
                  fontSize: 16.0,
                  fontFamily: kBoldStyle,
                ),
              ),
              Container(
                margin: EdgeInsetsResponsive.symmetric(
                  vertical: 16.0,
                ),
                child: TextField(
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  controller: _passwordController,
                  autocorrect: false,
                  autofocus: false,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    hintStyle: TextFieldStyle.getStyle(
                      textColor: kBlackColor,
                      fontSize: 16.0,
                      fontFamily: kRegularStyle,
                    ),
                    errorText:
                        _isValidPassword ? null : 'Please enter password',
                    errorStyle: TextFieldStyle.getStyle(
                      textColor: kErrorColor,
                      fontSize: 16.0,
                      fontFamily: kRegularStyle,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _isPasswordVisible = !_isPasswordVisible;
                        setState(() {});
                      },
                      child: CustomIcon(
                        color: kBlackColor,
                        size: 32,
                        iconData: _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  style: TextFieldStyle.getStyle(
                    textColor: kBlackColor,
                    fontSize: 16.0,
                    fontFamily: kBoldStyle,
                  ),
                ),
              ),
              CustomButton(
                onPressed: () {
                  _loader.show();
                  String name = _nameController.text;
                  String password = _passwordController.text;
                  if (name.isNotEmpty && password.isNotEmpty) {
                    _callWebFunction(
                      body: {
                        "name": name,
                        "pass": password,
                      },
                    );
                  } else {
                    _loader.hide();
                    if (name.isEmpty) {
                      _isValidName = false;
                    }
                    if (password.isEmpty) {
                      _isValidPassword = false;
                    }
                    setState(() {});
                    showSnackBar(
                      message: kFieldMiss,
                      type: kError,
                    );
                  }
                },
                textColor: kWhiteColor,
                titleSize: 16.0,
                fontFamily: kBoldStyle,
                title: 'Submit',
                height: 40,
                width: 320,
                cornerRadius: 0,
                backgroundColor: kBlackColor,
              )
            ],
          ),
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
    });
  }

  _callWebFunction({
    @required Map<String, dynamic> body,
  }) async {
    Response response = await _webFunctions.getLoginResponse(body: body);
    if (response != null) {
      Map<String, dynamic> res = jsonDecode(response.data);
      if (res['status'] == '200') {
        _loader.hide();
        LoginResponse loginResponse = LoginResponse.fromJson(res);
        await _sharedPreferenceHelper.set(
            kCsrfToken, loginResponse.currentUser.csrfToken);
        await _sharedPreferenceHelper.set(
            kLogoutToken, loginResponse.currentUser.logoutToken);
        navigationService.pushReplacement(
          route: DashBoardScreen(),
        );
      } else {
        _loader.hide();
        showSnackBar(
          message: res['message'],
          type: kError,
        );
      }
    } else {
      _loader.hide();
    }
  }
}
