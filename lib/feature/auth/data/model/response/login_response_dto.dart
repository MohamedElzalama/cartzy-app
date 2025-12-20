class LoginResponseDto {
  LoginResponseDto({this.accessToken, this.refreshToken});
  String? accessToken;
  String? refreshToken;
  String? message;
  int? statusCode;

  LoginResponseDto.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    message = json['message'];
    statusCode = json['statusCode'];
  }
}
