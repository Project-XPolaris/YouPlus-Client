class AppResponse {
  late int id;
  late String name;
  late String status;
  late bool autoStart;
  late String icon;

  AppResponse.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    autoStart = json['autoStart'];
    icon = json['icon'];
  }
}