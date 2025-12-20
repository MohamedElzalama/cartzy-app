import 'dart:convert';
import 'package:cartzy_app/core/utils/logging_service.dart';
import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/profile/data/model/response/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApi {
  ProfileApi._();
  static ProfileApi? _instance;
  static ProfileApi get instance => _instance ??= ProfileApi._();

  // https://api.escuelajs.co/api/v1/auth/profile

  Future<NetworkResult<UserModel>> getProfile() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      Uri url = Uri.https("api.escuelajs.co", "/api/v1/auth/profile");
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      var json = jsonDecode(response.body);
      LoggingService.instance.log(Level.info, json.toString());
      return NetworkSuccess(UserModel.fromJson(json));
    } catch (e) {
      LoggingService.instance.log(Level.error, e.toString());
      return NetworkError(e.toString());
    }
  }
}
