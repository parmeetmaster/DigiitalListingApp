enum NotificationAction { alert, created, updated }

NotificationAction exportType(String type) {
  switch (type) {
    case "create_post_listar":
    case "update_post_listar":
      return NotificationAction.created;
    default:
      return NotificationAction.alert;
  }
}

class NotificationModel {
  final NotificationAction action;
  final String title;
  final int id;

  NotificationModel({
    this.action,
    this.title,
    this.id,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      return NotificationModel(
        action: exportType(json['data']['action'] ?? 'Unknown'),
        title: json['data']['title'] as String ?? 'Unknown',
        id: int.tryParse(json['data']['id']?.toString()) ?? 0,
      );
    }
    return NotificationModel(
      action: exportType(json['action'] ?? 'Unknown'),
      title: json['title'] as String ?? 'Unknown',
      id: int.tryParse(json['id']?.toString()) ?? 0,
    );
  }
}
