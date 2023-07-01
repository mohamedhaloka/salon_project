class NotificationItemData {
  String? title;
  String? message;

  NotificationItemData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['body'];
  }
}
