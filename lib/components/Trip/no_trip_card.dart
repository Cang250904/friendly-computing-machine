import 'package:flutter/material.dart';

class NoTripCard extends StatelessWidget {
  const NoTripCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Chuyến Đi.',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // ✅ Cuộn ngang các nút
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 8),
              OutlinedButton.icon(
                icon: const Icon(Icons.calendar_today_outlined),
                label: const Text('Tất cả đơn đặt'),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Nhập Đơn đặt Bên ngoài'),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                icon: const Icon(Icons.attach_money),
                label: const Text('Bộ lọc thanh toán'),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),

        const SizedBox(height: 32),

        Center(
          child: Column(
            children: [
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/201/201623.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 16),
              const Text(
                'Không Có Chuyến Đi Nào Sắp Tới',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tìm kiếm đơn đặt và bắt đầu lập kế hoạch\ncho chuyến đi tiếp theo',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // TODO: navigate to search
                },
                child: const Text('Tìm kiếm đặt chỗ'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
