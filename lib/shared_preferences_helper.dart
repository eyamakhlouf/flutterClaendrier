import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final _storage = FlutterSecureStorage();

  // Save JWT token securely
  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  // Retrieve JWT token
  static Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  // Remove JWT token
  static Future<void> removeToken() async {
    await _storage.delete(key: 'jwt_token');
  }

  static Future<void> saveLoginState(bool isLoggedIn) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn); 
}

  // Retrieve login state
  static Future<bool?> getLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn');
  }

  // Save sessions
  static Future<void> saveSessions(List<Map<String, dynamic>> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    String sessionsJson = jsonEncode(sessions);
    await prefs.setString('sessions', sessionsJson);
  }

  // Load sessions
  static Future<List<Map<String, dynamic>>> loadSessions() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedSessions = prefs.getString('sessions');

    if (storedSessions != null) {
      List<dynamic> sessionList = jsonDecode(storedSessions);
      return sessionList.map((e) => Map<String, dynamic>.from(e)).toList();
    }
    return [];
  }

  // Clear login state (removes both login state and token)
  static Future<void> clearLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); // Remove login state
    await removeToken(); // Remove JWT token
  }
}
