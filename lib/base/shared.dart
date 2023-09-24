import 'package:shared_preferences/shared_preferences.dart';

class Shared{
  static Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }
  static void setPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('password', password);
  }


  static Future<String?> getInitState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('initState');
  }
  static void setInitState(String stateString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('initState', stateString);
  }
}