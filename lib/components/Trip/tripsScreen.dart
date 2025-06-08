import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doancuoiki/widget/hotel_card.dart';
import 'package:doancuoiki/models/hotel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Tripsscreen extends StatelessWidget {
  const Tripsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('hotels').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Lỗi tải dữ liệu: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final hotels = snapshot.data!.docs.map((doc) {
              return Hotel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
            }).toList();

            // Nhóm khách sạn theo thành phố
            final Map<String, List<Hotel>> hotelsByCity = {};
            for (var hotel in hotels) {
              hotelsByCity.putIfAbsent(hotel.location, () => []).add(hotel);
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Header Section ---
                  Row(
                    children: [
                      Text(
                        'Chuyến Đi.',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const CircleAvatar(radius: 5, backgroundColor: Colors.amber),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- Action Buttons ---
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.calendar_today_outlined, size: 18),
                            label: const Text('Tất cả đơn đặt', style: TextStyle(fontSize: 12)),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.add_circle_outline, size: 18),
                            label: const Text('Nhập Đơn đặt', style: TextStyle(fontSize: 12)),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.attach_money, size: 18),
                            label: const Text('Bộ lọc \n thanh toán', style: TextStyle(fontSize: 12)),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                  ),

                  const SizedBox(height: 32),

                  // --- No Upcoming Trips Section ---
                  Center(
                    child: Column(
                      children: [
                        Image.network(
                          'https://cdn-icons-png.flaticon.com/512/706/706797.png',
                          width: 120,
                          height: 120,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Không Có Chuyến Đi Nào Sắp Tới',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Tìm kiếm đơn đặt và bắt đầu lập kế hoạch\ncho chuyến đi tiếp theo của bạn.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Navigate to search
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber, // You can choose a primary color
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Tìm kiếm đặt chỗ',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                  const Divider(height: 1, color: Colors.grey),
                  const SizedBox(height: 32),

                  // --- "Where do you want to go next?" Section ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bạn muốn đi đâu tiếp theo?',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.filter_list, color: Colors.black54, size: 24),
                          SizedBox(width: 16),
                          Icon(Icons.add, color: Colors.black54, size: 24),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  // --- List of Hotels by City ---
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: hotelsByCity.entries.map((entry) {
                      final city = entry.key;
                      final cityHotels = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                city,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                            ],
                          ),
                          const SizedBox(height: 12),
                            SizedBox(
                              height: 290, // Adjusted height for better card display
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: cityHotels.length,
                                itemBuilder: (context, index) {
                                  final hotel = cityHotels[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 1), // Increased spacing between cards
                                    child: buildHotelCard(context, hotel),
                                  );
                                },
                              ),
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}