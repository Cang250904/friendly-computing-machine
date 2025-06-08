import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doancuoiki/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  static Future<UserModel?> fetchUser() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;

    final snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (snapshot.exists && snapshot.data() != null) {
      return UserModel.fromFireStore(snapshot.data()!);
    }

    return null;
  }

  Future<UserModel?> getCurrentUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
    if (!doc.exists) return null;

    final data = doc.data() as Map<String, dynamic>;
    return UserModel.fromFireStore(data);
  }
}