import 'package:doancuoiki/components/Sign%20in/enterEmail.dart';
import 'package:doancuoiki/components/Sign%20in/loginOption.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doancuoiki/models/user.dart';
import 'package:doancuoiki/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'detailUser.dart';

class AccountScreen extends StatefulWidget {
  final bool isLogin;

  const AccountScreen({
    super.key,
    this.isLogin = false,
  });

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final fetchedUser = await UserService.fetchUser();
      if (fetchedUser != null) {
        setState(() {
          user = fetchedUser;
        });
      }
    } else {
      setState(() => user = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    // Nếu chưa đăng nhập
    if (currentUser == null) {
      return Scaffold(
        backgroundColor: Color(0xd7e3e4e7),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildLogin(),
              _buildQuickActions(),
              _buildMainFeatures(),
              _buildPromotionButtons(),
              _buildFooterLinks(),
              _buildFooter(),
              const SizedBox(height: 40),],
          ),
        )

      );
    }

    // Đã đăng nhập nhưng chưa load xong dữ liệu
    if (user == null) {
      return const Scaffold(
        backgroundColor: Color(0xd7e3e4e7),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Đã đăng nhập và có dữ liệu
    return Scaffold(
      backgroundColor: Color(0xd7e3e4e7),
      body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context, user!),
              _buildStatusCards(user!),
              _buildEmailVerifyCard(),
              _buildQuickActions(),
              _buildMainFeatures(),
              _buildPromotionButtons(),
              _buildFooterLinks(),
              _buildFooter(),
              const SizedBox(height: 40),
            ],
          ),
        ),
    );
  }

  Widget _buildLogin() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(110),bottomRight: Radius.circular(110)),
            child : Image.asset(
                width: MediaQuery.of(context).size.width,
                'images/loginScreen.png',
                fit: BoxFit.cover
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const Text(
                  'Ưu đãi độc quyền dành riêng cho bạn - chỉ với một bước đơn giản!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                const Text(
                  '🎫 Tận Hưởng Quyền Lợi Thành Viên',
                  style: TextStyle(color: Colors.blueAccent),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (_) =>
                        LoginOptionsScreen()));
                      //   child: const Text(
                      //   'Đăng nhập/Đăng ký',
                      //   style: TextStyle(color: Colors.white),
                      // );
                    }, child: Text(
                    'Đăng nhập/Đăng ký',
                    style: TextStyle(color: Colors.white),
                  ),
                  ),
                ),
              ],
            ),
          ),
        ],
    );
  }

  Widget _buildEmailVerifyCard() {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.mail_outline, color: Colors.deepOrange),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              "Vui lòng xác minh email của bạn để sử dụng Trip Coin và giữ an toàn cho tài khoản",
              style: TextStyle(fontSize: 14),
            ),
          ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Container(
                width: 110,
                color: Color(0xff2c2cf1),
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Xác thực\n   email", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, UserModel user) {
    return Container(
      height: 100,
      color: Color(0xfff9fbfa),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            CircleAvatar(radius: 28, backgroundColor: Colors.grey[300]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Xin chào ${user.email}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  GestureDetector(
                      onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => DetailUser()));
                      },
                      child: Text('Quản lý Tài khoản của tôi', style: TextStyle(color: Colors.grey[600], fontSize: 14)))
                ],
              ),
            ),
            Icon(Icons.settings)
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCards(UserModel user) {
    return Container(
      height: 140,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(10,10,10,5),
          child: Card(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _iconTile("≈${user.tripCoins}đ", "Trip Coins"),
                    _iconTile("${user.vouchers}", "Mã Khuyến Mãi"),
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      height: 140,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,10,10,5),
        child: Card(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _quickAction(Icons.list_alt, 'Tất cả đơn đặt'),
                  _quickAction(Icons.backpack, 'Sắp Tới'),
                  _quickAction(Icons.history, 'Xem Gần Đây'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainFeatures() {
    final items = [
      _iconTile(Icons.edit_note_outlined, "Khoảnh khắc & Đánh giá"),
      _iconTile(Icons.favorite_outline, "Đã lưu"),
      _iconTile(Icons.credit_card, "Thẻ Của Tôi"),
      _iconTile(Icons.person_outline, "Du khách & Liên hệ"),
      _iconTile(Icons.headphones, "Chăm Sóc Khách Hàng"),
    ];

    return Container(
      height: 270,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,5,10,5),
        child: Card(
          color: Colors.white,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: items,
                  ),
               ],
             ),
          )
      ),
    );
  }

  Widget _buildPromotionButtons() {
    return Container(
      height: 130,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,5,10,5),
        child: Card(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _iconTile(Icons.card_giftcard, 'Bài Đăng Của Tôi'),
                  _iconTile(Icons.card_membership, 'Thẻ Quà Tặng'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterLinks() {
    return Container(
      height: 130,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,5,10,5),
        child: Card(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _iconTile(Icons.info_outline, 'Giới thiệu về\nTrip.com'),
                  _iconTile(Icons.star_outline, 'Đánh giá ứng\ndụng này'),
                  _iconTile(Icons.article_outlined, 'Điều khoản &\nĐiều kiện'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text('Dịch vụ mà bạn có thể tin cậy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(CupertinoIcons.heart, size: 13),
                    Text(' Hỗ trợ toàn cầu trong 30 giây', style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 10),
                Text('|', style: TextStyle(fontSize: 13)),
                SizedBox(width: 10),
                Row(
                  children: [
                    Icon(CupertinoIcons.heart,size: 13),
                    Text(' Vô Tư Du Lịch', style: TextStyle(fontSize: 13)),
                    ]
                )
            ],
          )
          ],
        ),
      ),
    );
  }

  Widget _quickAction(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: const Color(0x37cdcbcb),
          child: Icon(icon, color: const Color(0xff255df9)),
        ),
        const SizedBox(height: 6),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }

  Widget _iconTile(dynamic icon, String label) {
    return Column(
      children: [
        icon is IconData
            ? Icon(icon, size: 28, color: Colors.black)
            : Text(icon, style: const TextStyle(fontSize: 24, color: Colors.black)),
        const SizedBox(height: 6),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }
}
