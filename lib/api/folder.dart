class ShareFolder {
  late int id;
  late String name;
  ShareFolder.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.id = json["id"];
  }
}