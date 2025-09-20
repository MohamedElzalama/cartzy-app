class LoginResponseDto {
  LoginResponseDto({this.accessToken, this.refreshToken});
  String? accessToken;
  String? refreshToken;

  LoginResponseDto.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }
}
