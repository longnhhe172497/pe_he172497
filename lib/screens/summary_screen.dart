import 'package:flutter/material.dart';
import '../models/order_model.dart';
import 'ai_diary_screen.dart';

class SummaryScreen extends StatelessWidget {
  final OrderModel order;
  const SummaryScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ORDER SUMMARY"),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Card hiển thị thông tin đơn hàng (Task 8)
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Icon(Icons.check_circle_outline, size: 60, color: Colors.green),
                    const SizedBox(height: 10),
                    const Text(
                      "Order Confirmed",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Divider(height: 30),

                    // Chi tiết đơn hàng
                    _infoRow("Customer Name:", order.customerName),
                    _infoRow("Phone Number:", order.phoneNumber),
                    _infoRow("Brand Selection:", order.brand),
                    _infoRow("Shoe Size:", "${order.shoeSize}"),
                    _infoRow("Quantity:", "${order.quantity}"),

                    // Hiển thị Design Description nếu là Luxury Custom (Task 8 logic)
                    if (order.isBespoke)
                      _infoRow("Bespoke Design:", order.designDescription),

                    const Divider(height: 30),
                    _infoRow(
                        "TOTAL AMOUNT:",
                        "\$${order.totalAmount.toStringAsFixed(2)}",
                        isTotal: true
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Nút End Session để sang AI Diary (Task 8)
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // Điều hướng và xóa toàn bộ stack cũ
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const AIDiaryScreen()),
                        (route) => false,
                  );
                },
                child: const Text(
                    "END SESSION",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Hàm helper để tạo các dòng thông tin (Đã sửa lỗi TextStyle)
  Widget _infoRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        // Sửa từ .between thành .spaceBetween
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              label,
              style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
                fontSize: isTotal ? 18 : 15,
              )
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                fontSize: isTotal ? 22 : 15,
                color: isTotal ? Colors.blueAccent : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}