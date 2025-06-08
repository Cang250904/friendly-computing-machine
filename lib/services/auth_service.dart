import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // SỬA Ở ĐÂY: Truyền clientId cho Web
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '896621147541-n78trfaoaacvsgvt9dace8e7pu18svfl.apps.googleusercontent.com',
  );

  // Lấy user hiện tại
  User? get currentUser => _auth.currentUser;

  // Stream để theo dõi trạng thái đăng nhập
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Đăng nhập bằng Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      throw e;
    } catch (e) {
      print('Google Sign In Error: $e');
      throw e;
    }
  }

  // Đăng xuất
  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      print('Sign Out Error: $e');
      throw e;
    }
  }

  // Kiểm tra xem user đã đăng nhập chưa
  bool isSignedIn() {
    return _auth.currentUser != null;
  }

  // Lấy thông tin user
  Map<String, dynamic>? getUserInfo() {
    final User? user = _auth.currentUser;
    if (user != null) {
      return {
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'photoURL': user.photoURL,
        'emailVerified': user.emailVerified,
      };
    }
    return null;
  }
}
