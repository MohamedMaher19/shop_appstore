import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences ?sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
//////////////////////////////////////////////////////////////////
//   static Future<bool> putBoolean(   // news app
//       {required String key,
//         required bool value
//       }) async
//   {
//     return await sharedPreferences!.setBool(key, value);
//   }
//
//   //////////////////////////////////////////////////////////////////
//
//   static bool? getBoolean ({required String key}){    // news app
//     return sharedPreferences!.getBool(key);
//   }

//////////////////////////////////////////////////////////////////////


  static Future<bool> saveData(  // shop app
      {
        required String key,
        required dynamic value,

      })async

  {
    if (value is bool) return await sharedPreferences! .setBool(key, value);
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);

    return await sharedPreferences!.setDouble(key, value);

  }
  /////////////////////////////////////////////////////////

  static dynamic getData({  // المسؤله عن اتيان الداتا ال اتبعتت من ميثود ال saveData
   required String key ,

}) {
    return sharedPreferences!.get(key);
  }


/////////////////////////////////////////////////////////////////////
  static Future<bool>  removeData ({
  required String key
}) async
  {

     return await sharedPreferences!.remove(key); // طبيعي ان لازم هيعمل ريموف لحاجه ليها key

  }

}