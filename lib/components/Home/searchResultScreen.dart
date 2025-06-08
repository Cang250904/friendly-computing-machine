import 'package:doancuoiki/models/hotel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'hotelDetailScreen.dart';
import 'package:doancuoiki/widget/searchResultWidget.dart';
import 'package:doancuoiki/widget/searchBarWidget.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreen();
}

class _SearchResultScreen extends State<SearchResultScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
          children: [
        ColoredBox(
        color: Colors.blueAccent,
          child: Column(
            children: [
              SearchBarWidget(
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
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _filterButton("Sắp xếp", Icons.sort, ),
                    _filterButton("Bộ lọc", Icons.tune),
                    _filterButton("Vị trí", Icons.location_on),
                    _filterButton("2 người lớn", Icons.people),
                  ],
                ),
              ),
            ],
          ),
    ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Đã tìm thấy chỗ nghỉ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("hotels").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        
                  final docs = snapshot.data!.docs;
        
                  return ListView.builder(
                    itemCount: docs.length,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final hotel = Hotel.fromFirestore(doc.data(), doc.id);
        
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HotelDetailScreen(hotel: hotel),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(child: SearchResultWidget(hotel: hotel))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
    );
  }

  Widget _filterButton(String label, IconData icon) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16, color: Colors.white,),
      label: Text(label, style: const TextStyle(fontSize: 12,color: Colors.white)),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        side: const BorderSide(color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6)
      ),
    );
  }
}
