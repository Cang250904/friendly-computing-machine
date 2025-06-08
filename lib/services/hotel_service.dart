import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doancuoiki/models/hotel.dart';

class HotelService {
  final CollectionReference _hotelRef = FirebaseFirestore.instance.collection('hotels');

  Future<void> addHotel(Hotel hotel) async {
    await _hotelRef.add(hotel.toMap());
  }

  Stream<List<Hotel>> getHotels() {
    return _hotelRef.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Hotel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  Future<void> deleteHotel(String id) async {
    await _hotelRef.doc(id).delete();
  }

  Future<void> updateHotel(String id, Hotel hotel) async {
    await _hotelRef.doc(id).update(hotel.toMap());
  }
}
