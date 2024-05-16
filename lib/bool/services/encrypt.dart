import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

String encryptAES(String data, String key) {
  final keyBytes = Uint8List.fromList(utf8.encode(key));
  final iv = IV.fromUtf8('RandomInitVector');
  final encrypter = Encrypter(AES(Key(keyBytes), mode: AESMode.cbc));
  final encrypted = encrypter.encrypt(data, iv: iv);
  return base64Encode(encrypted.bytes);
}
