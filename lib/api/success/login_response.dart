// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.message,
    this.status,
    this.currentUser,
  });

  String message;
  String status;
  CurrentUser currentUser;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json["message"],
        status: json["status"],
        currentUser: CurrentUser.fromJson(json["current_user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "current_user": currentUser.toJson(),
      };
}

class CurrentUser {
  CurrentUser({
    this.uid,
    this.name,
    this.csrfToken,
    this.logoutToken,
    this.showQuickAccessScreen,
  });

  String uid;
  String name;
  String csrfToken;
  String logoutToken;
  int showQuickAccessScreen;

  factory CurrentUser.fromJson(Map<String, dynamic> json) => CurrentUser(
        uid: json["uid"],
        name: json["name"],
        csrfToken: json["csrf_token"],
        logoutToken: json["logout_token"],
        showQuickAccessScreen: json["show_quick_access_screen"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "csrf_token": csrfToken,
        "logout_token": logoutToken,
        "show_quick_access_screen": showQuickAccessScreen,
      };
}
