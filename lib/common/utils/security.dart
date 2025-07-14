import 'dart:convert';
import 'package:crypto/crypto.dart';

///md5加密
String securityMD5(String input) {
  String salt = ''; // 加盐
  var bytes = utf8.encode(input + salt);
  var digest = md5.convert(bytes);

  return digest.toString();
}
