import 'package:shared_preferences/shared_preferences.dart';

bool notEmpty(dynamic value) {
  if (value == null) return false;
  if (value.toString().isEmpty) return false;
  return true;
}

Future<void> saveLocal(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<void> clearLocal(
  String key,
) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}

Future<String?> getLocal(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString(key);
  return jsonString;
}
