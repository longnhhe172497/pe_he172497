import 'package:flutter/material.dart';
import '../models/order_model.dart';
import 'calculation_screen.dart'; // File sẽ tạo ở bước sau

class SizingInventoryScreen extends StatefulWidget {
  final OrderModel order;
  const SizingInventoryScreen({super.key, required this.order});

  @override
  State<SizingInventoryScreen> createState() => _SizingInventoryScreenState();
}

class _SizingInventoryScreenState extends State<SizingInventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SIZING & INVENTORY")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Shoe Size: ${widget.order.shoeSize}", style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Slider(
              value: widget.order.shoeSize.toDouble(),
              min: 35, max: 50, divisions: 15,
              onChanged: (val) => setState(() => widget.order.shoeSize = val.toInt()),
            ),
            if (widget.order.shoeSize > 44)
              const Text("Note: 10% Over-size surcharge applied", style: TextStyle(color: Colors.red)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CalculationScreen(order: widget.order))),
              child: const Text("CONTINUE"),
            )
          ],
        ),
      ),
    );
  }
}