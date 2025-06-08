import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:doancuoiki/firebase_options.dart';
import 'package:doancuoiki/components/Home/homeScreen.dart';
import 'package:doancuoiki/components/chat/homeChat_screen.dart';
import 'package:doancuoiki/components/Trip/tripsScreen.dart';
import 'package:doancuoiki/components/Sign in/accountScreen.dart';
import 'package:doancuoiki/components/Sign in/enterEmail.dart';
import 'package:doancuoiki/widget/bottom_navbar.dart';

import 'components/chat/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isLogin = FirebaseAuth.instance.currentUser != null;

  final PageController _pageController = PageController();

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void _goToLogin() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EnterEmailScreen(),
      ),
    );

    if (result == true) {
      setState(() {
        _isLogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeScreen(),
      ChatScreen(),
      Tripsscreen(),
      AccountScreen(isLogin: _isLogin),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
