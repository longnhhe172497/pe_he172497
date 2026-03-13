import 'package:flutter/material.dart';
import '../models/order_model.dart';
import 'sizing_inventory_screen.dart';

class CustomerInfoScreen extends StatefulWidget {
  final OrderModel order;
  const CustomerInfoScreen({super.key, required this.order});

  @override
  State<CustomerInfoScreen> createState() => _CustomerInfoScreenState();
}

class _CustomerInfoScreenState extends State<CustomerInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CUSTOMER INFORMATION")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Full Name", border: OutlineInputBorder()),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Cannot be empty";
                  if (RegExp(r'[0-9]').hasMatch(val)) return "Name must not contain numbers";
                  return null;
                },
                onChanged: (val) => widget.order.customerName = val,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: "Phone Number", border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Cannot be empty";
                  if (!RegExp(r'^(03|05|07|08|09)[0-9]{8}$').hasMatch(val)) return "Invalid VN Phone (10 digits)";
                  return null;
                },
                onChanged: (val) => widget.order.phoneNumber = val,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SizingInventoryScreen(order: widget.order)));
                  }
                },
                child: const Text("CONTINUE"),
              )
            ],
          ),
        ),
      ),
    );
  }
}