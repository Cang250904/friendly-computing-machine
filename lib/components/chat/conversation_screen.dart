import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEF1F8),
        title: const Text(
          'Tin Nhắn',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0A2647),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0A2647)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.headset_mic_outlined, color: Color(0xFF0A2647)),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                _buildTab('Trò chuyện', isSelected: true),
                _buildTab('Đơn Đặt'),
                _buildTab('Phần Thưởng Chuyến Đi'),
                _buildTab('Kh'),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
                            child: const Icon(
                              Icons.send,
                              color: Colors.amber,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
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
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                const Row(
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 3,
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}