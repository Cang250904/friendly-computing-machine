import 'package:flutter/material.dart';
import '../widget/colors.dart';

class ChatInput extends StatefulWidget {
  final Function(String) onSendMessage;

  const ChatInput({Key? key, required this.onSendMessage}) : super(key: key);

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSendMessage(_controller.text.trim());
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Nhập tin nhắn...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: AppColors.lightGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              onPressed: _sendMessage,
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}