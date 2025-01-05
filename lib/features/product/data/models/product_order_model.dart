import 'package:loging_app/features/product/domain/entities/product.dart';
import 'package:loging_app/features/product/domain/entities/product_order.dart';

class ProductOrderModel {
  final int quantity;
  final DateTime date;
  final String status;
  final String sellerLocation;
  final String buyerLocation;
  final String sellerName;
  final String buyerName;

  const ProductOrderModel({
    required this.quantity,
    required this.date,
    required this.status,
    required this.sellerLocation,
    required this.buyerLocation,
    required this.sellerName,
    required this.buyerName,
  });

  /// Factory constructor for creating a `ProductOrderModel` from a Map (e.g., JSON)
  factory ProductOrderModel.fromMap(Map<String, dynamic> map) {
    return ProductOrderModel(
      quantity: map['cantidad'] as int,
      date: DateTime.parse(map['fechaPedido'] as String),
      status: map['estadoPedido'] as String,
      sellerLocation: map['ubicacionVendedor'] as String? ?? 'Ubicacion no especificada',
      buyerLocation: map['ubicacionCliente'] as String? ?? 'Ubicacion no especificada',
      sellerName: map['nombreVendedor'] as String,
      buyerName: map['nombreCliente'] as String,
    );
  }

  /// Converts a `ProductOrderModel` into a Map (e.g., for JSON serialization)
  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'date': date.toIso8601String(),
      'status': status,
      'sellerLocation': sellerLocation,
      'buyerLocation': buyerLocation,
      'sellerName': sellerName,
      'buyerName': buyerName,
    };
  }

  /// CopyWith method for creating a new instance with modified values
  ProductOrderModel copyWith({
    int? quantity,
    DateTime? date,
    String? status,
    String? sellerLocation,
    String? buyerLocation,
    String? sellerName,
    String? buyerName,
  }) {
    return ProductOrderModel(
      quantity: quantity ?? this.quantity,
      date: date ?? this.date,
      status: status ?? this.status,
      sellerLocation: sellerLocation ?? this.sellerLocation,
      buyerLocation: buyerLocation ?? this.buyerLocation,
      sellerName: sellerName ?? this.sellerName,
      buyerName: buyerName ?? this.buyerName,
    );
  }

  /// Static method for creating a `ProductOrderModel` from JSON
  static Future<ProductOrderModel> fromJson(Map<String, dynamic> data) async {
    if (data == null) {
      throw Exception('Data is null');
    }
    return ProductOrderModel.fromMap(data);
  }


  //Return a ProductOrder entity from a ProductOrderModel
  ProductOrder toEntity() {
    return ProductOrder(
      quantity: quantity,
      date: date,
      status: status,
      sellerLocation: sellerLocation,
      buyerLocation: buyerLocation,
      sellerName: sellerName,
      buyerName: buyerName,
    );
  }
}
