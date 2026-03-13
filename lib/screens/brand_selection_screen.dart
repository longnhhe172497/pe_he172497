import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../models/student_model.dart';
import 'customer_info_screen.dart';

class BrandSelectionScreen extends StatefulWidget {
  final Student student;
  const BrandSelectionScreen({super.key, required this.student});

  @override
  State<BrandSelectionScreen> createState() => _BrandSelectionScreenState();
}

class _BrandSelectionScreenState extends State<BrandSelectionScreen> {
  final List<String> brands = ['Nike', 'Adidas', 'Jordan', 'Luxury Custom'];
  String? selectedBrand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WELCOME TO SNEAKER-X"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Hiển thị thông tin sinh viên từ JSON (Identity)
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 10),
                Text("${widget.student.name} | ${widget.student.studentId}"),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Select a Brand:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: brands.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final brand = brands[index];
                final isSelected = selectedBrand == brand;
                return ListTile(
                  title: Text(brand, style: TextStyle(
                      color: isSelected ? Colors.blue : Colors.black,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
                  )),
                  trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.blue) : null,
                  onTap: () => setState(() => selectedBrand = brand),
                );
              },
            ),
          ),
          if (selectedBrand == "Luxury Custom")
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: const [
                  Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Bespoke Design Requirement: you must provide a design description in later steps.",
                      style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: selectedBrand == null ? null : () {
                  bool isBespoke = (selectedBrand == "Luxury Custom");

                  // Lệnh chuyển trang quan trọng nhất:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerInfoScreen(
                              order: OrderModel(brand: selectedBrand!, isBespoke: isBespoke)
                          )
                      )
                  );
                },
                child: const Text("CONTINUE", style: TextStyle(color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}