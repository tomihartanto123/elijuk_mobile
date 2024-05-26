import 'package:e_lijuk/model/user_model_s.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserLevel {
  penjual,
  pembeli,
}

class PasarAjaUserService {
  static const userId = 'iduser';
  static const sandi = 'sandi';
  static const email = 'email';
  static const fullName = 'fullname';
  static const level = 'level';
  static const photo = 'photo';
  static const deviceToken = 'device_token';
  static const shopId = 'id_shop';
  static const shopName = 'shop_name';
  static const shopPhone = 'shop_phone_number';
  static const shopDesc = 'shop_description';

  /// cek apakah user sudah login atau belum
  static Future<bool> isLoggedIn() async {
    // get email
    String userEmail = await getEmailLogged();

    return userEmail.isNotEmpty || userEmail.trim().isNotEmpty;
  }

  // get user data
  static Future<String> getUserData(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(data)) {
      return prefs.getString(data) ?? '';
    } else {
      return '';
    }
  }

  static Future<String> getEmailLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(email)) {
      return prefs.getString(email) ?? '';
    } else {
      return '';
    }
  }

  static Future<int> getUserDataInt(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(data)) {
      return prefs.getInt(data) ?? 0;
    } else {
      return 0;
    }
  }

  static Future<int> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(userId)) {
      return prefs.getInt(userId) ?? 0;
    } else {
      return 0;
    }
  }

  static Future<int> getShopId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(shopId)) {
      return prefs.getInt(shopId) ?? 0;
    } else {
      return 0;
    }
  }

  // set user data
  static Future<void> setUserData(String data, String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(data, value ?? '');
  }

  static Future<void> setUserDataInt(String data, int? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(data, value ?? 0);
  }

  /// login
  static Future<void> login(UserModel user) async {
    await setUserDataInt(userId, int.parse(user.idUser));
    await setUserData(sandi, user.kataSandi);
    await setUserData(email, user.email);
    await setUserData(fullName, user.namaPengguna);
    await setUserData(level, user.role);
    await setUserData(photo, user.foto);
  }

  /// logout
  static Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userId);
    await prefs.remove(sandi);
    await prefs.remove(email);
    await prefs.remove(fullName);
    await prefs.remove(photo);
    await prefs.remove(level);
    await prefs.remove(deviceToken);
    await prefs.remove(shopId);
    await prefs.remove(shopName);
    await prefs.remove(shopPhone);
    await prefs.remove(shopDesc);
  }
}
