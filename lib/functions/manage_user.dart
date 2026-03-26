import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserManagement {
  Future<void> save_user_data(Map<String, dynamic> data) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String map = json.encode(data);
    await preferences.setString("user_data", map);
  }

  Future<Map<String, dynamic>?> load_user_data() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? map = preferences.getString("user_data");
    if (map != null) {
      Map<String, dynamic> user_data = json.decode(map) as Map<String, dynamic>;
      return user_data;
    }
    return null;
  }
}
