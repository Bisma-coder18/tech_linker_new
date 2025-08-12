import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_linker_new/models/institute-model.dart';
import 'package:tech_linker_new/models/student.dart';
import 'dart:convert';
import 'package:tech_linker_new/services/api.dart';

class LocalStorage {
  
  // Save login token
  static Future<bool> setData(String key,dynamic value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(key, value);
    } catch (e) {
      print('❌ Error saving token: $e');
      return false;
    }
  }

  // Get saved token
  static Future<String?> getData(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } catch (e) {
      print('❌ Error getting token: $e');
      return null;
    }
  }

  // Save user data
  static Future<bool> saveUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = jsonEncode(user.toJson());
      return await prefs.setString(AppKeys.userkey, userJson);
    } catch (e) {
      print('❌ Error saving user: $e');
      return false;
    }
  }
  static Future<bool> saveInstUser(InstituteModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = jsonEncode(user.toJson());
      print(userJson);
      print(">>>>>>>>>>>");
      return await prefs.setString(AppKeys.userkey, userJson);
    } catch (e) {
      print('❌ Error saving user: $e');
      return false;
    }
  }

  // Get saved user
  static Future<User?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(AppKeys.userkey);
    
      if (userJson != null) {
        final userData = jsonDecode(userJson);
        return User.fromJson(userData);
      }
      
      return null;
    } catch (e) {
      print('❌ Error getting user: $e');
      return null;
    }
  }
   static Future<InstituteModel?> getInsUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final userJson = prefs.getString(AppKeys.userkey);
    
      if (userJson != null) {
        final userData = jsonDecode(userJson);
        
        return InstituteModel.fromJson(userData);
      }
      
      return null;
    } catch (e) {
      print('❌ Error getting user: $e');
      return null;
    }
  }

  // Clear all saved data (logout)
  static Future<bool> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return true;
    } catch (e) {
      print('❌ Error clearing data: $e');
      return false;
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final user = await getUser();
    return user != null ;
  }
}