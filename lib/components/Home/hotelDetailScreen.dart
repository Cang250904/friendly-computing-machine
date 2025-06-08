import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doancuoiki/models/hotel.dart';
import 'package:doancuoiki/widget/RattingStarWidget.dart';

class HotelDetailScreen extends StatelessWidget {
  final Hotel hotel;

  const HotelDetailScreen({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text(hotel.name),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh khách sạn
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.network(
                hotel.imageUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên khách sạn và đánh giá
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          hotel.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                            StarRating(rating: hotel.rating)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${hotel.rating}/10 · ${hotel.reviewCount} đánh giá',
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          hotel.location,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Bảng giá khuyến mãi
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (hotel.roomsLeft > 0)
                          Text(
                            '⚡ Chỉ còn ${hotel.roomsLeft} phòng giá này',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            if ((hotel.originalPrice) > (hotel.discountPrice))
                              Text(
                                '${hotel.originalPrice}đ',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            SizedBox(width: 8),
                            Text(
                              '${hotel.discountPrice}đ',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Tổng giá: ${hotel.discountPrice}đ (đã gồm thuế & phí)',
                          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
