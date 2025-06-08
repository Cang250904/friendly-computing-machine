import 'package:doancuoiki/models/notificationModel.dart';
import 'package:flutter/material.dart';
import 'package:doancuoiki/widget/message_category_tabs.dart';
import 'package:doancuoiki/widget/notification_card.dart';

class HomeChatScreen extends StatefulWidget {
  const HomeChatScreen({super.key});

  @override
  State<HomeChatScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeChatScreen> {
  int _selectedIndex = 1;
  
  final List<NotificationModel> notificationsModels = [
    NotificationModel(
      icon: 'T',
      title: 'Quý khách đã được tham gia! Chào mừng quý khách đến với chương trình',
      subtitle: 'Hiện quý khách đang là Thành viên Hạng bạc. Nhấn vào đây để khám phá các quyền lợi của',
      date: '16 thg 5',
      isNew: true,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF1F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEF1F8),
        title: const Text(
          'Tin Nhắn',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0A2647),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.store_outlined, color: Color(0xFF0A2647)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.headset_mic_outlined, color: Color(0xFF0A2647)),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MessageCategoryTabs(),
          Expanded(
            child: _selectedIndex == 1 
                ? NotificationsList(notifications: notificationsModels)
                : const ConversationEmptyState(),
          ),
        ],
      ),
    );
  }
}

class NotificationsList extends StatelessWidget {
  final List<NotificationModel> notifications;

  const NotificationsList({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
          child: Text(
            'Thông Báo Gần Đây',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4A6572),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return NotificationCard(notification: notifications[index]);
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Text(
            'Thông báo từ 6 tháng qua',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

class ConversationEmptyState extends StatelessWidget {
  const ConversationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/mailbox.png',
                  width: 80,
                  height: 80,
                  color: Colors.blue[400],
                ),
                Positioned(
                  top: 30,
                  left: 30,
                  child: Transform.rotate(
                    angle: -0.5,
                    child: Icon(
                      Icons.send,
                      color: Colors.amber,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Chưa có lịch sử trò chuyện',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 60),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.teal, size: 20),
              SizedBox(width: 5),
              Text(
                'Hỗ trợ toàn cầu trong 30 giây',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(width: 20),
              Icon(Icons.check_circle, color: Colors.teal, size: 20),
              SizedBox(width: 5),
              Text(
                'Vô Tư Du Lịch',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Tự Tin Đặt Chỗ Trên Trip.com',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
