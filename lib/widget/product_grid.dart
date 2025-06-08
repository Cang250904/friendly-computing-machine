import 'package:doancuoiki/widget/RattingStarWidget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doancuoiki/models/hotel.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('hotels').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Lỗi: ${snapshot.error}');
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

        final hotels = snapshot.data!.docs.map((doc) {
          return Hotel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();

        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.74,
          ),
          itemCount: hotels.length,
          itemBuilder: (context, index) {
            return buildProductCard(hotels[index]);
          },
        );
      },
    );
  }

  Widget buildProductCard(Hotel hotel) {
    final discountPercent = ((1 - hotel.discountPrice / hotel.originalPrice) * 100).round();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hotel image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              hotel.imageUrl,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Hotel details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Địa điểm
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.blueAccent, size: 14),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        hotel.location,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),

                // Tên khách sạn
                Text(
                  hotel.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),

                // Rating và đánh giá
                StarRating(rating: hotel.rating, size: 15),
                Row(
                  children: [

                    Text(
                      '${hotel.rating}',
                      style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '/10  ·  ${hotel.reviewCount} đánh giá',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                SizedBox(height: 4),

                // Giá
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Text(
                      '${hotel.originalPrice.toStringAsFixed(0)}₫',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      '${hotel.discountPrice.toStringAsFixed(0)}₫',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),

                // Giảm giá
                if (discountPercent > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Giảm $discountPercent%',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
