import 'dart:convert';

import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSession {
  static Future<dynamic> writeGlobalUserDataToLocal() async {
    return await AppSession.saveItem('userData', GlobalDataSource.userData.toMap());
  }
  static Future<dynamic> saveItem(String key, dynamic value) async {
    var result = await FlutterSession().set(key, const JsonEncoder().convert(value));
    return result;
  }

  static Future<dynamic> getItem(String key) async {
    var result = await FlutterSession().get(key);
    return result;
  }

  static Future<void> deleteItem(String key, dynamic value) async {
    return await FlutterSession().remove(key);
  }

  static Future<void> clear() async {
    return await FlutterSession().clear();
  }
}

/// Copyright (c) 2020, Jhourlad Estrella.
/// All rights reserved. Use of this source code is governed by a
/// MIT-style license that can be found in the LICENSE.md file.

/// flutter_session file package.
///
/// Adds session-like functionality to Flutter
// library flutter_session;

/// flutter_session
/// A package that adds session functionality to Flutter
class FlutterSession {
  /// Initialize session container
  Map _session = {};

  // Yes, it uses SharedPreferences
  SharedPreferences? prefs;

  // Initialize the SharedPreferences instance
  Future _initSharedPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  /// Item setter
  ///
  /// @param key String
  /// @returns Future
  Future get(key) async {
    await _initSharedPrefs();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return json.decode(prefs!.get(key).toString());
    } catch (e) {
      return prefs!.get(key);
    }
  }

  /// Item remove
  ///
  /// @param key String
  /// @returns Future
  Future remove(key) async {
    await _initSharedPrefs();
    try {
      prefs!.remove(key);
      return true;
    } catch (e) {
      return false;
    }
  }


  /// clear
  ///
  /// 
  /// @returns Future
  Future clear() async {
    await _initSharedPrefs();
    try {
      prefs!.clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Item setter
  ///
  /// @param key String
  /// @param value any
  /// @returns Future
  Future set(key, value) async {
    await _initSharedPrefs();

    // Detect item type
    switch (value.runtimeType) {
      // String
      case String:
        {
          prefs!.setString(key, value);
        }
        break;

      // Integer
      case int:
        {
          prefs!.setInt(key, value);
        }
        break;

      // Boolean
      case bool:
        {
          prefs!.setBool(key, value);
        }
        break;

      // Double
      case double:
        {
          prefs!.setDouble(key, value);
        }
        break;

      // List<String>
      case List:
        {
          prefs!.setStringList(key, value);
        }
        break;

      // Object
      default:
        {
          prefs!.setString(key, jsonEncode(value.toJson()));
        }
    }

    // Add item to session container
    _session.putIfAbsent(key, () => value);
  }
}