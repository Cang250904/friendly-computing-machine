import 'package:doancuoiki/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'enterEmail.dart';

class LoginOptionsScreen extends StatefulWidget {
  const LoginOptionsScreen({super.key});

  @override
  State<LoginOptionsScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginOptionsScreen> {
  final GoogleAuthService _authService = GoogleAuthService();
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userCredential = await _authService.signInWithGoogle();
      
      if (userCredential != null) {
        // Đăng nhập thành công
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      }
    } catch (e) {
      // Xử lý lỗi
      if (mounted) {
        _showErrorDialog(_getErrorMessage(e.toString()));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _getErrorMessage(String error) {
    if (error.contains('network-request-failed')) {
      return 'Không có kết nối mạng. Vui lòng kiểm tra và thử lại.';
    } else if (error.contains('too-many-requests')) {
      return 'Quá nhiều yêu cầu. Vui lòng thử lại sau.';
    } else if (error.contains('user-disabled')) {
      return 'Tài khoản đã bị vô hiệu hóa.';
    }
    return 'Đăng nhập thất bại. Vui lòng thử lại.';
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lỗi đăng nhập'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              // Icon Close
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Image.asset('images/logo.png'),
                  )
                ],
              ),

              // Logo + Hình ảnh
              const SizedBox(height: 12),
              Image.asset(
                'images/loginOption1.jpg',
                height: 200,
              ),

              const SizedBox(height: 12),

              // Tiêu đề
              const Text(
                'Đăng Nhập / Đăng Ký',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const Text(
                '🎫 Tận Hưởng Quyền Lợi Thành Viên',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 50),

              // Các nút đăng nhập
              _buildLoginButton(
                icon: Icons.email,
                label: 'Tiếp Tục Với Email',
                backgroundColor: Colors.blue,
                iconColor: Colors.white,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => EnterEmailScreen()));
                }
              ),

              // Nút Google với loading state
              _buildGoogleLoginButton(),

              _buildLoginButton(
                icon: Icons.apple,
                label: 'Tiếp Tục Với Tài Khoản Apple',
                backgroundColor: Colors.black,
                textColor: Colors.white,
                onPressed: () {
                  // TODO: Apple sign in
                },
              ),

              _buildLoginButton(
                icon: Icons.facebook,
                label: 'Tiếp Tục Với Facebook',
                backgroundColor: const Color(0xFF1877F2),
                iconColor: Colors.white,
                onPressed: () {
                  // TODO: Facebook sign in
                },
              ),

              const Spacer(),

              // Điều khoản
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text.rich(
                  TextSpan(
                    text: 'Tiếp tục thao tác nghĩa là tôi đã đọc và đồng ý với ',
                    children: [
                      TextSpan(
                        text: 'Điều khoản & Điều kiện',
                        style: TextStyle(color: Colors.blue),
                      ),
                      const TextSpan(text: ' và '),
                      TextSpan(
                        text: 'Cam kết bảo mật',
                        style: TextStyle(color: Colors.blue),
                      ),
                      const TextSpan(text: ' của Trip.com.'),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget riêng cho nút Google với loading state
  Widget _buildGoogleLoginButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : _handleGoogleSignIn,
        icon: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              )
            : Image.network(
                'https://cdn-icons-png.flaticon.com/512/300/300221.png',
                width: 20,
                height: 20,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback nếu không load được icon
                  return const Icon(Icons.account_circle, color: Colors.grey);
                },
              ),
        label: Text(
          _isLoading ? 'Đang đăng nhập...' : 'Tiếp Tục Với Google',
          style: const TextStyle(color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          elevation: 1,
        ),
      ),
    );
  }

  Widget _buildLoginButton({
    IconData? icon,
    String? imageAsset,
    required String label,
    required VoidCallback? onPressed,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.white,
    Color iconColor = Colors.black,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: imageAsset != null
            ? Image.network(
                imageAsset, 
                width: 20, 
                height: 20,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(icon ?? Icons.error, color: iconColor);
                },
              )
            : Icon(icon, color: iconColor),
        label: Text(label, style: TextStyle(color: textColor)),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: backgroundColor == Colors.white 
                ? BorderSide(color: Colors.grey.shade300)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}