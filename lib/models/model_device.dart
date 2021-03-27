class DeviceModel {
  String uuid;
  String userID;
  String name;
  String model;
  String version;
  String token;
  String type;
  bool used;
  DateTime lastAccessTime;
  DateTime registerTime;

  DeviceModel({
    this.uuid,
    this.userID,
    this.name,
    this.model,
    this.version,
    this.token,
    this.type,
    this.used,
    this.lastAccessTime,
    this.registerTime,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    final access = json['last_access_time'];
    final register = json['register_time'];

    DateTime accessTime;
    DateTime registerTime;

    if (access is num) {
      accessTime = new DateTime.fromMicrosecondsSinceEpoch(access * 1000);
    }
    if (register is num) {
      registerTime = new DateTime.fromMicrosecondsSinceEpoch(register * 1000);
    }

    return DeviceModel(
      uuid: json['_id'] as String ?? '',
      userID: json['user_id'] as String ?? '',
      name: json['name'] as String ?? '',
      model: json['model'] as String ?? '',
      version: json['version'] as String ?? '',
      token: json['token'] as String ?? '',
      type: json['type'] as String ?? '',
      used: json['use_device'] as bool ?? false,
      lastAccessTime: accessTime,
      registerTime: registerTime,
    );
  }
}
