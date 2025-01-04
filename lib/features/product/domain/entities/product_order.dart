import 'package:loging_app/features/product/domain/entities/product.dart';

class ProductOrder {
  final Product product;
  final int quantity;
  final DateTime date;
  final String status;
  final String sellerLocation;

  ProductOrder(
    this.date,
    this.status,
    this.sellerLocation, {
    required this.product,
    required this.quantity,
  });
}
