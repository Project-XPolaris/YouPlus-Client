class UserAuthResponse {
  bool success = false;
  String? token;
  String? reason;
  UserAuthResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    reason = json['reason'];
  }
  UserAuthResponse(this.success, this.token);
}
class TokenResponse {
  late bool success;
  TokenResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }
}