import 'package:cloud_firestore/cloud_firestore.dart';

  Future<void> uploadSampleHotels() async {
    final collection = FirebaseFirestore.instance.collection('hotels');

    final sampleHotels = [
      {
        'name': 'Sapa Mountain View',
        'description': 'Khách sạn nằm giữa núi rừng Sapa với tầm nhìn tuyệt đẹp.',
        'originalPrice': 900000,
        'discountPrice': 750000,
        'location': 'Sapa',
        'rating': 4.5,
        'reviews': 150,
        'roomsLeft': 3,
        'discount': 17,
        'imageUrl': 'https://cf.bstatic.com/xdata/images/hotel/max1024x768/285158444.jpg',
        'city': 'Lào Cai',
      },
      {
        'name': 'Khách sạn Lộc Phát',
        'description': 'Khách sạn 3 sao tại trung tâm Đà Nẵng, gần cầu Rồng.',
        'originalPrice': 750000,
        'discountPrice': 600000,
        'location': 'Đà Nẵng',
        'rating': 4.3,
        'reviews': 89,
        'roomsLeft': 2,
        'discount': 20,
        'imageUrl': 'https://cf.bstatic.com/xdata/images/hotel/max1024x768/348777885.jpg',
        'city': 'Đà Nẵng',
      },
      {
        'name': 'The Grand Saigon',
        'description': 'Khách sạn cao cấp 5 sao nằm tại trung tâm TP. Hồ Chí Minh.',
        'originalPrice': 2000000,
        'discountPrice': 1700000,
        'location': 'TP. Hồ Chí Minh',
        'rating': 4.8,
        'reviews': 234,
        'roomsLeft': 5,
        'discount': 15,
        'imageUrl': 'https://pix10.agoda.net/hotelImages/124/1246280/1246280_16042115500041700644.jpg',
        'city': 'Hồ Chí Minh',
      },
      {
        'name': '"Du thuyền Saigon Princess"',
        'description': 'Du thuyền sang trọng với các bữa tối trên sông Sài Gòn.',
        'originalPrice': 750000,
        'discountPrice': 650000,
        'location': 'Sài Gòn',
        'rating': 4.3,
        'reviews': 25,
        'roomsLeft': 1,
        'discount': 13,
        'imageUrl': 'https://cdn1.ivivu.com/iVivu/2023/05/25/15/du-thuyen-saigon-princess-ivivu-3.jpg',
        'city': 'Hồ Chí Minh',
      },
    ];

    for (var hotel in sampleHotels) {
      await collection.add(hotel);
    }

    print('✅ Dữ liệu mẫu đã được thêm.');
  }
