import 'package:doancuoiki/components/Sign%20in/enterEmail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doancuoiki/models/user.dart';
import 'accountScreen.dart';
import 'package:doancuoiki/main.dart';
class EnterPasswordScreen extends StatefulWidget {
  final String email;
  final bool isLogin;

  const EnterPasswordScreen({
    super.key,
    required this.email,
    required this.isLogin,
  });

  @override
  State<EnterPasswordScreen> createState() => _PasswordEntryScreenState();
}

class _PasswordEntryScreenState extends State<EnterPasswordScreen> {
  bool _isLogin = FirebaseAuth.instance.currentUser != null;
  final passwordController = TextEditingController();
  bool isLoading = false;
  final auth = FirebaseAuth.instance;
  bool obscurePassword = true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // Debug kiểm tra giá trị được truyền vào
    print('⚙️ EnterPasswordScreen - isLogin: ${widget.isLogin}, email: ${widget.email}');
  }

  void handleAuth() async {
    setState(() => isLoading = true);
    try {
      UserCredential userCredential;

      if (widget.isLogin) {
        // Đăng nhập
        print("🔑 Thực hiện đăng nhập...");
        userCredential = await auth.signInWithEmailAndPassword(
          email: widget.email,
          password: passwordController.text,
        );
      } else {
        // Đăng ký
        print("📝 Tạo tài khoản mới...");
        userCredential = await auth.createUserWithEmailAndPassword(
          email: widget.email,
          password: passwordController.text,
        );

        // Tạo bản ghi Firestore mới
        final user = userCredential.user;
        if (user != null) {
          final userModel = UserModel(uid: user.uid, email: user.email!);
          await _firestore.collection("users").doc(user.uid).set(
              userModel.toMap());
        }
      }

      Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => MainScreen()
        //     AccountScreen(
        //   isLogin: true,
        //   onLoginPressed: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (_) => EnterEmailScreen()));
        //   },
        // )
        ),
          (route) => false,
      );

    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // Tài khoản đã tồn tại, nhưng đang ở chế độ đăng ký → chuyển sang đăng nhập
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                EnterPasswordScreen(
                  email: widget.email,
                  isLogin: true,
                ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: ${e.message}')),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isLogin ? "Đăng Nhập" : "Tạo Tài Khoản",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.isLogin
                  ? "Nhập mật khẩu để đăng nhập tài khoản của bạn:"
                  : "Đặt mật khẩu cho tài khoản mới của bạn:",
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                labelText: "Mật khẩu",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() => obscurePassword = !obscurePassword),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ, số và ký hiệu.",
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  isLoading ? null : handleAuth();
                },
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                  widget.isLogin ? "Đăng Nhập" : "Đăng ký và Đăng nhập",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (!widget.isLogin) ...[
              Text.rich(
                TextSpan(
                  text: "Khi đăng ký tài khoản Trip.com, tôi xác nhận là tôi đã đọc và đồng ý với ",
                  style: const TextStyle(fontSize: 12),
                  children: [
                    TextSpan(
                      text: "Điều khoản & Điều kiện",
                      style: const TextStyle(decoration: TextDecoration.underline),
                    ),
                    const TextSpan(text: " và "),
                    TextSpan(
                      text: "Tuyên bố quyền riêng tư",
                      style: const TextStyle(decoration: TextDecoration.underline),
                    ),
                    const TextSpan(text: " của Trip.com"),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ]
          ],
        ),
      ),
    );
  }
}
