import 'package:cartzy_app/core/constants/app_keys.dart';

class RegisterRequestDto {
  const RegisterRequestDto({
    this.name,
    this.email,
    this.password,
    this.avatar = AppKeys.avatar,
  });
  final String? name;
  final String? email;
  final String? password;
  final String? avatar;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['avatar'] = avatar;
    return data;
  }
}
