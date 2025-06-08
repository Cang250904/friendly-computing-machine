import 'package:doancuoiki/widget/RattingStarWidget.dart';
import 'package:flutter/material.dart';
import 'package:doancuoiki/models/hotel.dart';

class SearchResultWidget extends StatelessWidget {
  final Hotel hotel;
  const SearchResultWidget({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 120,
                height: 220,
                child: Image.network(
                  hotel.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên khách sạn + sao
                  Row(
                    children: [
                      StarRating(rating: hotel.rating)
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Đánh giá
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Color(0xFF0707A5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${hotel.rating.toString()}/10',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text('Tot', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      Text('${hotel.reviewCount} đánh giá'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(hotel.description, style: TextStyle(color: Colors.grey[800])),
                  const SizedBox(height: 4),
                  Text(
                    'Chỉ còn ${hotel.roomsLeft} phòng có giá này',
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  // Giá
                      Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.pink[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text('Giảm Giá Đặc Biệt',
                            style: const TextStyle(color: Colors.pink, fontSize: 12),
                          ),
                        ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Color(0xfffd3475),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${(100 - (hotel.discountPrice / hotel.originalPrice * 100)).round()}%',
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${hotel.originalPrice}₫',
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${hotel.discountPrice}₫',
                            style: const TextStyle(
                              color: Color(0xff0b1ffb),
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Tổng giá: ${hotel.discountPrice}₫ \nbao gồm thuế và phí',
                          style: TextStyle(fontSize: 14),),
                        ],
                      )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}