import 'package:dio/dio.dart';

import '../../domain/entities/products_order.dart';

class ProductsOrderModel extends ProductOrder {
  ProductsOrderModel({
    required super.idPedido,
    required super.estadoPedido,
    required super.fechaPedido,
    required super.idCliente,
    required super.idProducto,
    required super.nombreCliente,
  });

  /// Crea una instancia de `ProductsOrderModel` desde un JSON
  factory ProductsOrderModel.fromJson(Map<String, dynamic> json) {
  return ProductsOrderModel(
    idPedido: json['idPedido'] as int? ?? 0, // Manejo de null con valor por defecto
    estadoPedido: json['estadoPedido'] as String? ?? 'Desconocido', // Manejo de null
    fechaPedido: json['fechaPedido'] != null
        ? DateTime.parse(json['fechaPedido'] as String)
        : DateTime.now(), // Manejo de null
    idCliente: json['idCliente'] as int? ?? 0, // Si no existe, asigna 0
    idProducto: json['idProducto'] as int? ?? 0, // Si no existe, asigna 0
    nombreCliente: json['nombreCliente'] as String? ?? 'Sin nombre', // Manejo de null
  );
}


  /// Convierte un `ProductsOrderModel` en un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'idPedido': idPedido,
      'estadoPedido': estadoPedido,
      'fechaPedido': fechaPedido.toIso8601String(),
      'idCliente': idCliente,
      'idProducto': idProducto,
    };
  }

  /// Convierte un `ProductsOrderModel` en un `FormData`
  FormData toFormData() {
    return FormData.fromMap({
      'idPedido': idPedido,
      'estadoPedido': estadoPedido,
      'fechaPedido': fechaPedido.toIso8601String(),
      'idCliente': idCliente,
      'idProducto': idProducto,
    });
  }

  /// Convierte un `ProductsOrderModel` en una entidad del dominio `ProductsOrder`
  ProductOrder toDomain() {
    return ProductOrder(
      idPedido: idPedido,
      estadoPedido: estadoPedido,
      fechaPedido: fechaPedido,
      idCliente: idCliente,
      idProducto: idProducto,
      nombreCliente: nombreCliente
    );
  }

  /// Crea una instancia de `ProductsOrderModel` desde una entidad del dominio `ProductsOrder`
  factory ProductsOrderModel.fromEntity(ProductOrder order) {
    return ProductsOrderModel(
      idPedido: order.idPedido,
      estadoPedido: order.estadoPedido,
      fechaPedido: order.fechaPedido,
      idCliente: order.idCliente,
      idProducto: order.idProducto,
      nombreCliente: order.nombreCliente,
    );
  }
}
