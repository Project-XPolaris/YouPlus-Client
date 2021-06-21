class AppResponse {
  late String id;
  late String name;
  late int pid;
  late String status;
  late bool autoStart;
  late String icon;

  AppResponse.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pid = json['pid'];
    status = json['status'];
    autoStart = json['auto_start'];
    icon = json['icon'];
  }
}