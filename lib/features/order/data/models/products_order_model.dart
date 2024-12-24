import 'package:dio/dio.dart';

import '../../domain/entities/products_order.dart';

class ProductsOrderModel extends ProductsOrder {
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
      idPedido: json['idPedido'] as int,
      estadoPedido: json['estadoPedido'] as String,
      fechaPedido: DateTime.parse(json['fechaPedido'] as String),
      idCliente: json['idCliente'] as int,
      idProducto: json['idProducto'] as int,
      nombreCliente: json['nombreCliente'] as String,
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
  ProductsOrder toDomain() {
    return ProductsOrder(
      idPedido: idPedido,
      estadoPedido: estadoPedido,
      fechaPedido: fechaPedido,
      idCliente: idCliente,
      idProducto: idProducto,
      nombreCliente: nombreCliente
    );
  }

  /// Crea una instancia de `ProductsOrderModel` desde una entidad del dominio `ProductsOrder`
  factory ProductsOrderModel.fromEntity(ProductsOrder order) {
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
