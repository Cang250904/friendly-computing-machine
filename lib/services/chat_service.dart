import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Gửi tin nhắn
  Future<void> sendMessage(String senderId, String senderName, String text) async {
    try {
      await _firestore.collection('messages').add({
        'senderId': senderId,
        'senderName': senderName,
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  // Lấy stream tin nhắn
  Stream<List<Message>> getMessages() {
    return _firestore
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Message.fromFirestore(doc))
          .toList();
    });
  }

  // Xóa tin nhắn
  Future<void> deleteMessage(String messageId) async {
    try {
      await _firestore.collection('messages').doc(messageId).delete();
    } catch (e) {
      print('Error deleting message: $e');
    }
  }
}