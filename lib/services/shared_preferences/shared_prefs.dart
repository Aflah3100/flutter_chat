import 'package:flutter_chat/database/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


//Shared Preferences helper class for creating fetching and deleting shared pref values
class SharedPrefs {
  //Keys
  final String _userModelkey = 'usermodel';
  //Singleton
  SharedPrefs._internal();
  static SharedPrefs instance = SharedPrefs._internal();
  factory SharedPrefs() => instance;

  //Create shared pref object using user model object
  Future<bool> saveUserModel({required UserModel user}) async {
    final sharedPrefObject = await SharedPreferences.getInstance();
    await sharedPrefObject.setString(_userModelkey, user.toJson());
    return true;
  }

  //retrieve user model object from shared pref
  Future<UserModel?> getUserModel() async {
    final sharedPrefObject = await SharedPreferences.getInstance();
    String? userModelJson = sharedPrefObject.getString(_userModelkey);
    if (userModelJson != null) {
      return UserModel.fromJson(userModelJson);
    }
    return null;
  }

  // delete user model from shared pref
  Future<void> deleteUserModel() async {
    final sharedPrefObject = await SharedPreferences.getInstance();
    sharedPrefObject.remove(_userModelkey);
  }
}
