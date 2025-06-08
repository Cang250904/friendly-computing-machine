import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:doancuoiki/main.dart';

class DetailUser extends StatelessWidget {
  const DetailUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              Navigator.pop(context, MaterialPageRoute(builder: (_) => MainScreen()));
            },
            child: Icon(Icons.logout)),
        ElevatedButton(onPressed: () async {
      await FirebaseAuth.instance.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (_) => MainScreen()));
    },
    child: Text('đăng xuất'))
      ],
    );
  }
}
