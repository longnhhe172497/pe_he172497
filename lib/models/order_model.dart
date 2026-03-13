class OrderModel {
  String brand;
  bool isBespoke;
  String customerName = "";
  String phoneNumber = "";
  int shoeSize = 35;
  int quantity = 1;
  String designDescription = "";
  String promoCode = "";

  OrderModel({required this.brand, required this.isBespoke});

  // Task 6: Base Price theo yêu cầu đề bài
  double get basePrice {
    if (brand == 'Nike') return 200.0;
    if (brand == 'Adidas') return 180.0;
    if (brand == 'Jordan') return 250.0;
    if (brand == 'Luxury Custom') return 500.0;
    return 0.0;
  }

  // Task 5: Phụ phí 10% nếu size > 44
  double get overSizeFee {
    if (shoeSize > 44) {
      return (basePrice * quantity) * 0.10;
    }
    return 0.0;
  }

  // Task 6: Công thức tính tổng
  double get totalAmount {
    return (basePrice * quantity) + overSizeFee;
  }
}