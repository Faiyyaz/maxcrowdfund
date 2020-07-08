// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    this.mesaage,
    this.message,
    this.status,
  });

  String mesaage;
  String message;
  int status;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        mesaage: json["mesaage"] == null ? null : json["mesaage"],
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "mesaage": mesaage == null ? null : mesaage,
        "status": status == null ? null : status,
        "message": message == null ? null : message,
      };
}
