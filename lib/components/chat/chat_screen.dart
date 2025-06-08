import 'package:flutter/material.dart';
import 'package:doancuoiki/services/user_service.dart';
import 'package:doancuoiki/services/chat_service.dart';
import 'package:doancuoiki/models/message.dart';
import 'package:doancuoiki/widget/message_bubble.dart';
import 'package:doancuoiki/widget/chat_input.dart';
import 'package:doancuoiki/widget/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final UserService _authService = UserService();
  final ChatService _chatService = ChatService();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Tin Nhắn',
          style: TextStyle(
            color: AppColors.darkGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.headset_mic, color: AppColors.darkGrey),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Colors.white,
            child: Row(
              children: [
                _buildTabItem('Trò chuyện', true),
                _buildTabItem('Đơn Đặt', false),
                _buildTabItem('Phần Thưởng Chuyến Đi', false),
                _buildTabItem('Khuyến Mãi', false),
              ],
            ),
          ),

          // Messages List
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _chatService.getMessages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 80,
                          color: AppColors.lightGrey,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Chưa có tin nhắn nào',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Hãy bắt đầu cuộc trò chuyện!',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final messages = snapshot.data!;

                // Auto scroll to bottom when new message arrives
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                });

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message.senderId == _authService.currentUser?.uid;

                    return MessageBubble(
                      message: message,
                      isMe: isMe,
                    );
                  },
                );
              },
            ),
          ),

          // Chat Input
          ChatInput(
            onSendMessage: _sendMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Future<void> _sendMessage(String text) async {
    final user = _authService.currentUser;
    if (user == null) return;

    final userData = await _authService.getCurrentUserData();
    if (userData == null) return;

    await _chatService.sendMessage(
      user.uid,
      userData.name ?? '',
      text,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}