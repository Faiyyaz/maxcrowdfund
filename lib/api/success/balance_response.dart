// To parse this JSON data, do
//
//     final balanceResponse = balanceResponseFromJson(jsonString);

import 'dart:convert';

BalanceResponse balanceResponseFromJson(String str) =>
    BalanceResponse.fromJson(json.decode(str));

String balanceResponseToJson(BalanceResponse data) =>
    json.encode(data.toJson());

class BalanceResponse {
  BalanceResponse({
    this.userLoginStatus,
    this.balance,
    this.portfolio,
    this.netReturn,
  });

  int userLoginStatus;
  Balance balance;
  Portfolio portfolio;
  NetReturn netReturn;

  factory BalanceResponse.fromJson(Map<String, dynamic> json) =>
      BalanceResponse(
        userLoginStatus: json["user_login_status"],
        balance:
            json["balance"] == null ? null : Balance.fromJson(json["balance"]),
        portfolio: json["portfolio"] == null
            ? null
            : Portfolio.fromJson(json["portfolio"]),
        netReturn: json["net_return"] == null
            ? null
            : NetReturn.fromJson(json["net_return"]),
      );

  Map<String, dynamic> toJson() => {
        "user_login_status": userLoginStatus,
        "balance": balance == null ? null : balance.toJson(),
        "portfolio": portfolio == null ? null : portfolio.toJson(),
        "net_return": netReturn == null ? null : netReturn.toJson(),
      };
}

class Balance {
  Balance({
    this.heading,
    this.data,
  });

  String heading;
  Map<String, Datum> data;

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        heading: json["heading"] == null ? null : json["heading"],
        data: json["data"] == null
            ? null
            : Map.from(json["data"])
                .map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "heading": heading == null ? null : heading,
        "data": data == null
            ? null
            : Map.from(data)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Datum {
  Datum({
    this.title,
    this.value,
    this.type,
  });

  String title;
  String value;
  Type type;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        value: json["value"],
        type: typeValues.map[json["type"]],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
        "type": typeValues.reverse[type],
      };
}

enum Type { C, D }

final typeValues = EnumValues({"C": Type.C, "D": Type.D});

class NetReturn {
  NetReturn({
    this.heading,
    this.data,
  });

  String heading;
  Data data;

  factory NetReturn.fromJson(Map<String, dynamic> json) => NetReturn(
        heading: json["heading"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "heading": heading,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.netReturn,
    this.averageReturn,
    this.incidentalPayments,
    this.fees,
    this.reserved,
    this.writtenOff,
    this.lastNetReturn,
  });

  AverageReturn netReturn;
  AverageReturn averageReturn;
  AverageReturn incidentalPayments;
  AverageReturn fees;
  AverageReturn reserved;
  AverageReturn writtenOff;
  AverageReturn lastNetReturn;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        netReturn: AverageReturn.fromJson(json["net_return"]),
        averageReturn: AverageReturn.fromJson(json["average_return"]),
        incidentalPayments: AverageReturn.fromJson(json["incidental_payments"]),
        fees: AverageReturn.fromJson(json["fees"]),
        reserved: AverageReturn.fromJson(json["reserved"]),
        writtenOff: AverageReturn.fromJson(json["written_off"]),
        lastNetReturn: AverageReturn.fromJson(json["last_net_return"]),
      );

  Map<String, dynamic> toJson() => {
        "net_return": netReturn.toJson(),
        "average_return": averageReturn.toJson(),
        "incidental_payments": incidentalPayments.toJson(),
        "fees": fees.toJson(),
        "reserved": reserved.toJson(),
        "written_off": writtenOff.toJson(),
        "last_net_return": lastNetReturn.toJson(),
      };
}

class AverageReturn {
  AverageReturn({
    this.title,
    this.value,
  });

  String title;
  String value;

  factory AverageReturn.fromJson(Map<String, dynamic> json) => AverageReturn(
        title: json["title"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
      };
}

class Portfolio {
  Portfolio({
    this.heading,
    this.data,
  });

  String heading;
  Map<String, AverageReturn> data;

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
        heading: json["heading"],
        data: Map.from(json["data"]).map((k, v) =>
            MapEntry<String, AverageReturn>(k, AverageReturn.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "heading": heading,
        "data": Map.from(data)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}
