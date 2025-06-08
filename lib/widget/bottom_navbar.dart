import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Trang chủ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail),
          label: 'Tin nhắn',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_travel),
          label: 'Chuyến Đi',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Đăng Nhập',
        ),
      ],
    );
  }
}
