class UserAuthResponse {
  late bool success;
  late String token;
  UserAuthResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
  }
  UserAuthResponse(this.success, this.token);
}
class TokenResponse {
  late bool success;
  TokenResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }
}