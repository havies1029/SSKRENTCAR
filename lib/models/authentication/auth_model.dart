import 'dart:convert';
import 'package:rentcarapp/common/app_data.dart';
import 'package:flutter/cupertino.dart';

class UserInfo {
  UserLogin? userLogin;

  UserInfo({this.userLogin});

  Map<String, dynamic> toJson() => {"userinfo": userLogin?.toDatabaseJson()};
}

class UserLogin {
  String? username;
  String? password;

  UserLogin({this.username, this.password});

  Map<String, dynamic> toDatabaseJson() =>
      {"username": username, "password": password};
}

class Token {
  String? token;

  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(token: json['token']);
  }

  factory Token.split(String username, String tokeninfo) {
    debugPrint("Token.split");

    debugPrint("tokeninfo : $tokeninfo");

    List<String> info = tokeninfo.split(";");
    //String credentials = _info[2] + ":" + _info[0];
    String credentials = "$username:${info[0]}";

    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String enkriptToken = stringToBase64.encode(credentials);

    debugPrint("encripted token : $enkriptToken");

    AppData.userToken = enkriptToken;

    String dekripToken = stringToBase64.decode(enkriptToken);
    debugPrint("dekrip Token : $dekripToken");

    return Token(token: enkriptToken);
  }
}
