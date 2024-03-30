import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static SharedPreferencesManager? _instance;
  static SharedPreferences? _sharedPreferences;


  static const String name = 'username';
  static const String email = 'email';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String gender = 'gender';
  static const String image = 'image';
  static const String token = 'token';


  static Future<SharedPreferencesManager?> getInstance() async {
    _instance ??= SharedPreferencesManager();
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _instance;
  }

  Future<bool> putString(String key, String value) => _sharedPreferences!.setString(key, value);

  String? getString(String key) => _sharedPreferences!.getString(key);

  Future<bool> clearKey(String key) => _sharedPreferences!.remove(key);
}

 
Future<void> saveUserData({
  required String firstName,
  required String lastName,
  required String email,
  required String gender,
  required String image,
  required String token,
})async{
  SharedPreferencesManager? _manger = await SharedPreferencesManager.getInstance();

  _manger!.putString(SharedPreferencesManager.firstName, firstName);
  _manger.putString(SharedPreferencesManager.lastName, lastName);
  _manger.putString(SharedPreferencesManager.email, email);
  _manger.putString(SharedPreferencesManager.gender, gender);
  _manger.putString(SharedPreferencesManager.image, image);
  _manger.putString(SharedPreferencesManager.token, token);

}

class AccessTokenValidator{
  static Future<bool> isAlreadyLogin()async{
    SharedPreferencesManager? _manger = await SharedPreferencesManager.getInstance();

    if(_manger!.getString(SharedPreferencesManager.token) != null){
      return true;
    }
    return false;
  }
  static Future<void> clearToken()async{
    SharedPreferencesManager? _manger = await SharedPreferencesManager.getInstance();
    _manger!.clearKey(SharedPreferencesManager.token);
  }
}
