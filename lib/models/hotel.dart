class Hotel {
  final String id;
  final String name;
  final String description;
  final double originalPrice;
  final double discountPrice;
  final String location;
  final double rating;
  final int reviews;
  final int roomsLeft;
  final String imageUrl;
  final int reviewCount;
  final int promotion;

  Hotel({
    required this.id,
    required this.name,
    required this.description,
    required this.originalPrice,
    required this.discountPrice,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.roomsLeft,
    required this.imageUrl,
    required this.reviewCount,
    required this.promotion,
  });

  // Convert Firestore data → Hotel object
  factory Hotel.fromFirestore(Map<String, dynamic> map, String docId) {
    return Hotel(
      id: docId,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      originalPrice: (map['originalPrice'] ?? 0).toDouble(),
      discountPrice: (map['discountPrice'] ?? 0).toDouble(),
      location: map['location'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      reviews: (map['reviews'] ?? 0).toInt(),
      roomsLeft: (map['roomsLeft'] ?? 0).toInt(),
      imageUrl: map['imageUrl'] ?? '',
      reviewCount: map['reviewCount'] ?? 0,
      promotion: map['promotion'] ?? 0,
    );
  }


  // Convert Hotel object → Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'originalPrice': originalPrice,
      'discountPrice': discountPrice,
      'location': location,
      'rating': rating,
      'reviews': reviews,
      'roomsLeft': roomsLeft,
      'imageUrl': imageUrl,
      'reviewCount' :reviewCount,
      'promotion': promotion
    };
  }
}
