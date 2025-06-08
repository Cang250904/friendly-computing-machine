import 'package:flutter/material.dart';

class MessageCategoryTabs extends StatefulWidget {
  const MessageCategoryTabs({super.key});

  @override
  State<MessageCategoryTabs> createState() => _MessageCategoryTabsState();
}

class _MessageCategoryTabsState extends State<MessageCategoryTabs> {
  int _selectedTabIndex = 0;

  final List<Map<String, dynamic>> _tabs = [
    {
      'icon': Icons.chat_bubble_outline,
      'label': 'Trò chuyện',
      'color': Colors.teal,
    },
    {
      'icon': Icons.list_alt,
      'label': 'Đơn Đặt',
      'color': Colors.blue,
    },
    {
      'icon': Icons.card_giftcard,
      'label': 'Phần Thưởng Chuyến Đi',
      'color': Colors.orange,
      'notification': true,
    },
    {
      'icon': Icons.card_giftcard,
      'label': 'Khuyến Mãi',
      'color': Colors.pink,
    },
    {
      'icon': Icons.more_vert,
      'label': 'Hoạt',
      'color': Colors.deepPurple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          children: List.generate(_tabs.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              child: Container(
                width: 110,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _tabs[index]['color'].withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _tabs[index]['icon'],
                            color: _tabs[index]['color'],
                            size: 24,
                          ),
                        ),
                        if (_tabs[index]['notification'] == true)
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _tabs[index]['label'],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: _selectedTabIndex == index ? FontWeight.bold : FontWeight.normal,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 3,
                      width: 60,
                      color: _selectedTabIndex == index ? Colors.blue : Colors.transparent,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}