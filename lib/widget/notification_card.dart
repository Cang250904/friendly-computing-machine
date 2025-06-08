import 'package:flutter/material.dart';
import 'package:doancuoiki/models/notificationModel.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    notification.icon,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      notification.subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 68.0, right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '16 thg 5',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Xem Chi Tiết',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
