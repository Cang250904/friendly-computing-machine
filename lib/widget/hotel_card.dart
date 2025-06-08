import 'package:flutter/material.dart';
import 'package:doancuoiki/models/hotel.dart';
import 'package:doancuoiki/components/Home/hotelDetailScreen.dart';

Widget buildHotelCard(BuildContext context, Hotel hotel) {
  final discountPercent = ((1 - hotel.discountPrice / hotel.originalPrice) * 100).round();

  return Container(
    width: 210,
    margin: const EdgeInsets.only(right: 12),
    child: Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              hotel.imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text('⭐ ${hotel.rating}/10 • ${hotel.reviews} đánh giá',
                    style: const TextStyle(fontSize: 11)),
                Text(hotel.location,
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
                const SizedBox(height: 4),
                Text('Chỉ còn ${hotel.roomsLeft} phòng có giá này',
                    style: const TextStyle(fontSize: 11, color: Colors.red)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${hotel.originalPrice}đ',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${hotel.discountPrice}đ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.pink, borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        'Giảm ${discountPercent}',
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),

                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HotelDetailScreen(hotel: hotel),
                      ),
                    );
                  },
                  child: const Text(
                    'Đặt Ngay >',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
