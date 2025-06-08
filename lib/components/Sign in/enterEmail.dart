import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'enterPassword.dart';

class EnterEmailScreen extends StatefulWidget {
  const EnterEmailScreen({super.key});

  @override
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  void _checkEmailAndNavigate() async {
    String email = _emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập email hợp lệ')),
      );
      return;
    }
    setState(() => isLoading = true);
    try {

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: "temporary_dummy_password",
      );

      await FirebaseAuth.instance.currentUser?.delete();

      // Chuyển sang màn hình nhập mật khẩu với chế độ đăng ký
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => EnterPasswordScreen(email: email, isLogin: false),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => EnterPasswordScreen(email: email, isLogin: true),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: ${e.message}')),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Đăng Nhập Hoặc Tạo Tài Khoản',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Chúng tôi sẽ sử dụng thông tin này để đăng nhập hoặc tạo tài khoản cho bạn nếu bạn chưa có tài khoản',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _checkEmailAndNavigate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1877F2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Tiếp tục', style: TextStyle(fontSize: 16,color: Colors.white)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward,color: Colors.white,),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
