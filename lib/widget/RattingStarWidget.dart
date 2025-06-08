import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;
  final MainAxisAlignment alignment;

  const StarRating({
    super.key,
    required this.rating,
    this.size = 20,
    this.color = Colors.amber,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final filledStars = rating.floor();
    final halfStar = (rating - filledStars) >= 0.5;
    final emptyStars = 5 - filledStars - (halfStar ? 1 : 0);

    return Row(
      mainAxisAlignment: alignment,
      children: [
        for (int i = 0; i < filledStars; i++)
          Icon(Icons.star, color: color, size: size),
        if (halfStar)
          Icon(Icons.star_half, color: color, size: size),
        for (int i = 0; i < emptyStars; i++)
          Icon(Icons.star_border, color: color, size: size),
      ],
    );
  }
}
