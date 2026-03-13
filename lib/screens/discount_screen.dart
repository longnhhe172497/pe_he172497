import 'package:flutter/material.dart';
import '../models/order_model.dart';

class DiscountScreen extends StatefulWidget {
  final OrderModel order;
  const DiscountScreen({super.key, required this.order});

  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  String code = "";
  @override
  Widget build(BuildContext context) {
    bool isTotalValid = widget.order.totalAmount > 400;
    // Button disabled nếu nhập code mà tổng tiền ko đủ 400
    bool canContinue = code.isEmpty || isTotalValid;

    return Scaffold(
      appBar: AppBar(title: const Text("DISCOUNT CONSTRAINTS")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Order Total: \$${widget.order.totalAmount}"),
            TextField(
              decoration: const InputDecoration(labelText: "Promo Code (SNEAKER2024)"),
              onChanged: (val) => setState(() => code = val),
            ),
            if (code.isNotEmpty && !isTotalValid)
              const Text("Invalid: Total must be > \$400", style: TextStyle(color: Colors.red)),
            const Spacer(),
            ElevatedButton(
              onPressed: canContinue ? () {
                widget.order.promoCode = code;
                // Sang Screen 7 (Summary)
              } : null,
              child: const Text("CONTINUE"),
            )
          ],
        ),
      ),
    );
  }
}