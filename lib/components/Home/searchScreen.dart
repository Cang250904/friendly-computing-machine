import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doancuoiki/models/hotel.dart';
import 'searchResultScreen.dart';
import 'package:doancuoiki/widget/searchBarWidget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: SearchBarWidget(
            controller: searchController,
            onSearch: (value) {
              setState(() {
                searchQuery = value.toLowerCase();
              });
            },
        onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase();
              });
        },
        )
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (searchQuery.isEmpty)
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  "Từ khóa được đề xuất",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('hotels').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Center(child: Text('Lỗi: ${snapshot.error}'));
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                  final hotels = snapshot.data!.docs.map((doc) {
                    return Hotel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
                  }).toList();

                  // Lọc kết quả nếu có từ khóa
                  final filteredHotels = hotels.where((hotel) {
                    return hotel.name.toLowerCase().contains(searchQuery);
                  }).toList();

                  return ListView.separated(
                    itemCount: filteredHotels.length,
                    separatorBuilder: (_, __) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final hotel = filteredHotels[index];
                      return ListTile(
                        leading: Icon(Icons.hotel, color: Colors.blue),
                        title: Text(hotel.name),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchResultScreen(),

                            ),
                          );
                        },

                      );
                    },
                  );
                },
              ),
            ),
            if (searchQuery.isEmpty)
              Container(
                height: 140,
                color: Color(0xffeeeff4),
                padding: EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Tự Tin Đặt Chỗ Trên Trip.com",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                    SizedBox(height: 4),
                    Text(
                      "Hỗ trợ toàn cầu trong 30 giây   |   Vô Tư Du Lịch",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}