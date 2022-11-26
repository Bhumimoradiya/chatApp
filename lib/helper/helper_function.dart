import 'package:shared_preferences/shared_preferences.dart';

  bool issignedin = false;
class helperfunction {
  static String userloggedinkey = "LOGGEDINKEY";
  static String usernamekey = "USERNAMEKEY";
  static String useremailkey = "USEREMAILKEY";


  static Future<bool?> saveUserLoggedInStatus(bool isuserloggedin) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userloggedinkey, isuserloggedin);
  }

  static Future<bool?> saveUserNameSF(String username) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(usernamekey, username);
  }

  static Future<bool?> saveUserEmailSF(String useremail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(useremailkey, useremail);
  }

  static Future<String?> getUserNameSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(usernamekey);
  }

  static Future<String?> getUserEmailSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(useremailkey);
  }

  static Future<bool?> getuserloggedinstatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userloggedinkey);
  }
}
