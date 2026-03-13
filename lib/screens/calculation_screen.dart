import 'package:flutter/material.dart';
import '../models/order_model.dart';
import 'discount_screen.dart'; // File sẽ tạo ở bước sau

class CalculationScreen extends StatefulWidget {
  final OrderModel order;
  const CalculationScreen({super.key, required this.order});

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  @override
  Widget build(BuildContext context) {
    // Logic Task 6: Disable button nếu Luxury Custom mà chưa nhập description
    bool isInvalid = (widget.order.quantity <= 0) ||
        (widget.order.isBespoke && widget.order.designDescription.trim().isEmpty);

    return Scaffold(
      appBar: AppBar(title: const Text("REAL-TIME CALCULATION")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Quantity"),
              keyboardType: TextInputType.number,
              onChanged: (val) => setState(() => widget.order.quantity = int.tryParse(val) ?? 0),
            ),
            if (widget.order.isBespoke) ...[
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(labelText: "Design Description", border: OutlineInputBorder()),
                onChanged: (val) => setState(() => widget.order.designDescription = val),
              ),
            ],
            const Divider(height: 50),
            _row("Total Amount:", "\$${widget.order.totalAmount.toStringAsFixed(2)}"),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: isInvalid ? null : () => Navigator.push(context, MaterialPageRoute(builder: (context) => DiscountScreen(order: widget.order))),
              child: const Text("CONTINUE"),
            )
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      // Sửa từ .between thành .spaceBetween
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}