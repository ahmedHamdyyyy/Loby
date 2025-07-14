import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  late SharedPreferences storage;

  Future<bool> init() async {
    try {
      storage = await SharedPreferences.getInstance();
      return true;
    } on Exception catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }

  // Future<void> saveToken(String token) async {
  //   await storage.setString(_tokenKey, token);
  //   await storage.setBool(_isLoggedInKey, true);
  // }

  // String? getToken() {
  //   return storage.getString(_tokenKey);
  // }

  // Future<void> clearToken() async {
  //   await storage.remove(_tokenKey);
  //   await storage.remove(_isLoggedInKey);
  // }

  // Future<void> saveUserId(String userId) async {
  //   await storage.setString(_userIdKey, userId);
  // }

  // String? getUserId() {
  //   return storage.getString(_userIdKey);
  // }

  // Future<void> clearUserId() async {
  //   await storage.remove(_userIdKey);
  // }

  // bool isLoggedIn() {
  //   return storage.getBool(_isLoggedInKey) ?? false;
  // }

  // Future<void> logout() async {
  //   await clearToken();
  //   await clearUserId();
  //   //await shared.setBool(_isLoggedInKey, false);
  // }
}
