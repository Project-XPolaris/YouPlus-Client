class BaseResponse {
  late bool success;
  String? reason;
  BaseResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    success = json['success'];
    reason = json['reason'];
  }
  BaseResponse(this.success, this.reason);
}