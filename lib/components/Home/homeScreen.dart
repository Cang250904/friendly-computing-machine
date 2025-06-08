import 'package:doancuoiki/components/Home/hotelDetailScreen.dart';
import 'package:doancuoiki/widget/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:doancuoiki/components/Home/hotel_page.dart';
import 'package:doancuoiki/components/Home/searchScreen.dart';
import 'package:doancuoiki/models/hotel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> services = [
    {'icon': Icons.hotel, 'label': 'Khách sạn', 'page': HotelPage()},
    {'icon': Icons.flight, 'label': 'Vé Máy bay'},
    {'icon': Icons.card_travel, 'label': 'Combo Tiết Kiệm'},
    {'icon': Icons.train, 'label': 'Vé tàu'},
    {'icon': Icons.house, 'label': 'Nhà & Căn Hộ'},
    {'icon': Icons.tour, 'label': 'Tour & Hoạt Động'},
    {'icon': Icons.local_taxi, 'label': 'Đưa Đón Sân Bay'},
    {'icon': Icons.airplanemode_active, 'label': 'Trạng thái\nchuyến bay'},
    {'icon': Icons.more_horiz, 'label': '+2 mục khác'},
  ];

  final List<String> searchTags = [
    "Sunrise Airport Hotel",
    "Khách sạn ở TP. Hồ Chí Minh",
    "Khách sạn Hà Nội"
  ];


  @override
  Widget build(BuildContext context) {
    final Hotel hotel;

    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: GestureDetector(
          onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => SearchScreen()),
    );
    },
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              'Tìm kiếm',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ),
    ),
    ),
      body: ListView(
        // scrollDirection: Axis.horizontal,
        children: [
          // Tags
          Container(
            color: Colors.blueAccent,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  spacing: 8,
                  children: searchTags.map((tag) => Chip(
                    label: Text(tag,style: TextStyle(color: Colors.white)),
                    backgroundColor: Color(0xff1e52ec),
                  )).toList(),
                ),
            ),
            ),
          // Service icons
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 12),
            child: GridView.count(
              crossAxisCount: 5,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: services.map((item) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => item['page']),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.blue[50],
                        child: Icon(item['icon'], color: Colors.blue),
                      ),
                      SizedBox(height: 6),
                      Text(
                        item['label'],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // Example: recently searched hotel
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tiếp Tục Tìm Kiếm", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.hotel),
                    title: Text("Khách Sạn Tại TP. Hồ Chí Minh"),
                    subtitle: Text("21 thg 5 - 22 thg 5 | 2 người lớn"),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: ProductGrid(),
          ),
          StreamBuilder(
        stream: FirebaseFirestore.instance.collection("hotels").snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return Center(child: CircularProgressIndicator()
      );

      final docs = snapshot.data!.docs;
      return ListView.builder(
          itemCount: docs.length,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          itemBuilder: (context, index) {
            final doc = docs[index];
            final hotel = Hotel.fromFirestore(doc.data(), doc.id);
            child:
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (_) => HotelDetailScreen(hotel: hotel)));
                },
                child: ProductGrid());
          }
      );
    }    ),
    ],
      ),
    );
  }
}
