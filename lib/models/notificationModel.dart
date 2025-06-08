class NotificationModel {
  final String icon;
  final String title;
  final String subtitle;
  final String date;
  final bool isNew;

  NotificationModel({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.date,
    this.isNew = false,
  });
}
