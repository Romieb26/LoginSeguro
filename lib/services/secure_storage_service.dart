import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const FlutterSecureStorage storage =
  FlutterSecureStorage();

  // TOKEN
  static Future<void> saveToken(String token) async {
    await storage.write(
      key: 'token',
      value: token,
    );
  }

  static Future<String?> getToken() async {
    return await storage.read(
      key: 'token',
    );
  }

  // EXPIRATION
  static Future<void> saveExpiration(
      String expiration) async {
    await storage.write(
      key: 'expiration',
      value: expiration,
    );
  }

  static Future<String?> getExpiration() async {
    return await storage.read(
      key: 'expiration',
    );
  }

  // USER
  static Future<void> saveUser(
      String user) async {
    await storage.write(
      key: 'user',
      value: user,
    );
  }

  static Future<String?> getUser() async {
    return await storage.read(
      key: 'user',
    );
  }

  // EMAIL
  static Future<void> saveEmail(
      String email) async {
    await storage.write(
      key: 'email',
      value: email,
    );
  }

  static Future<String?> getEmail() async {
    return await storage.read(
      key: 'email',
    );
  }

  // BORRAR TODO
  static Future<void> clearSession() async {
    await storage.deleteAll();
  }
}