import 'package:loging_app/features/product/domain/entities/product.dart';

class ProductOrderModel {
  final Product product;
  final int quantity;
  final DateTime date;
  final String status;
  final String sellerLocation;

  const ProductOrderModel({
    required this.product,
    required this.quantity,
    required this.date,
    required this.status,
    required this.sellerLocation,
  });

  /// Factory constructor for creating a `ProductOrder` from a Map (e.g., JSON)
  factory ProductOrderModel.fromMap(Map<String, dynamic> map) {
    return ProductOrderModel(
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
      date: DateTime.parse(map['date'] as String),
      status: map['status'] as String,
      sellerLocation: map['sellerLocation'] as String,
    );
  }

  /// Converts a `ProductOrder` into a Map (e.g., for JSON serialization)
  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
      'date': date.toIso8601String(),
      'status': status,
      'sellerLocation': sellerLocation,
    };
  }

  /// CopyWith method for creating a new instance with modified values
  ProductOrderModel copyWith({
    Product? product,
    int? quantity,
    DateTime? date,
    String? status,
    String? sellerLocation,
  }) {
    return ProductOrderModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      date: date ?? this.date,
      status: status ?? this.status,
      sellerLocation: sellerLocation ?? this.sellerLocation,
    );
  }

  static Future<ProductOrderModel> fromJson(data) async {
    if (data == null) {
      throw Exception('Data is null');
    }
    return ProductOrderModel.fromMap(data);
  }
}
