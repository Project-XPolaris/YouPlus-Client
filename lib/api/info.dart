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