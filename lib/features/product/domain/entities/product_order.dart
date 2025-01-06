import 'package:loging_app/features/product/domain/entities/product.dart';

class ProductOrder {
  final int quantity;
  final DateTime date;
  final String status;
  final String sellerLocation;
  final String buyerLocation;
  final String sellerName;
  final String buyerName;

  ProductOrder({
    required this.quantity,
    required this.date,
    required this.status,
    required this.sellerLocation,
    required this.buyerLocation,
    required this.sellerName,
    required this.buyerName,
  });
}
