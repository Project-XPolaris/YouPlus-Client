class DiskListResponse {
  List<Disk>? disks;

  DiskListResponse({
      this.disks});

  DiskListResponse.fromJson(dynamic json) {
    if (json["disks"] != null) {
      disks = [];
      json["disks"].forEach((v) {
        disks?.add(Disk.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (disks != null) {
      map["disks"] = disks?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Disk {
  String? name;
  String? model;
  String? size;
  List<Part>? parts;

  Disk({
      this.name, 
      this.model, 
      this.size, 
      this.parts});

  Disk.fromJson(dynamic json) {
    name = json["name"];
    model = json["model"];
    size = json["size"];
    if (json["parts"] != null) {
      parts = [];
      json["parts"].forEach((v) {
        parts?.add(Part.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["model"] = model;
    map["size"] = size;
    if (parts != null) {
      map["parts"] = parts?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Part {
  String? name;
  String? fsType;
  String? size;
  String? mountpoint;

  Part({
      this.name, 
      this.fsType, 
      this.size, 
      this.mountpoint});

  Part.fromJson(dynamic json) {
    name = json["name"];
    fsType = json["fs_type"];
    size = json["size"];
    mountpoint = json["mountpoint"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["fs_type"] = fsType;
    map["size"] = size;
    map["mountpoint"] = mountpoint;
    return map;
  }

}