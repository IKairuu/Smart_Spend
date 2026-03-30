import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_spend/constants/notifier.dart';

class UserManagement {
  static Future<void> save_user_data(Map<String, dynamic> data) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String map = json.encode(data);
    await preferences.setString("user_data", map);
  }

  static Future<Map<String, dynamic>?> load_user_data() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? map = preferences.getString("user_data");
    if (map != null) {
      Map<String, dynamic> user_data = json.decode(map) as Map<String, dynamic>;
      return user_data;
    }
    return null;
  }

  static Future<void> clear_user_data() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    user_data.value = null;
    user_signed_in.value = false;
    await preferences.remove("user_data");
  }

  static String get_user_name(Map<String, dynamic> user) {
    return user_data.value!.keys.toList()[0];
  }
}
