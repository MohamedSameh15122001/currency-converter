// import 'package:shared_preferences/shared_preferences.dart';

// class CacheHelper {
//   static SharedPreferences? sharedPreferences;

//   static init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }

//   //put data and save
//   static Future<bool> saveData({
//     required key,
//     required value,
//   }) async {
//     if (value is String) return await sharedPreferences!.setString(key, value);
//     if (value is bool) return await sharedPreferences!.setBool(key, value);
//     if (value is int) return await sharedPreferences!.setInt(key, value);
//     return await sharedPreferences!.setDouble(key, value);
//   }

//   //get data
//   static dynamic getData(String key) {
//     return sharedPreferences!.get(key);
//   }

//   //delete data
//   static Future<bool> removeData(key) async {
//     return await sharedPreferences!.remove(key);
//   }
// }