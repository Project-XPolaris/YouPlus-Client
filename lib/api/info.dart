class DeviceInfo {
  late String hostname;
  late String os;
  late String board;
  late String cpu;
  DeviceInfo.fromJson(Map<String, dynamic> json) {
    this.hostname = json["node"]["hostname"];
    this.os = json["os"]["name"];
    this.board = json["board"]["name"];
    this.cpu = json["cpu"]["model"];
  }
}

class NasInfo {
  late int appCount;
  late int diskCount;
  late int shareFolderCount;
  late int storageCount;
  late int userCount;
  late int zfsCount;
  NasInfo.fromJson(Map<String, dynamic> json) {
    this.appCount = json['appCount'];
    this.diskCount = json['diskCount'];
    this.shareFolderCount = json['shareFolderCount'];
    this.storageCount = json['storageCount'];
    this.userCount = json['userCount'];
    this.zfsCount = json['zfsCount'];
  }
}