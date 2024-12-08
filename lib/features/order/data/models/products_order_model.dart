import 'package:dio/dio.dart';

import '../../domain/entities/products_order.dart';

class ProductsOrderModel extends ProductsOrder {
  ProductsOrderModel({
    required super.idPedido,
    required super.estado,
    required super.entregado,
    required super.fechaPedido,
    required super.idUsuario,
    required super.idProducto,
  });

  /// Crea una instancia de `ProductsOrderModel` desde un JSON
  factory ProductsOrderModel.fromJson(Map<String, dynamic> json) {
  return ProductsOrderModel(
    idPedido: json['idPedido'] as int,
    estado: json['estado'] as String,
    entregado: (json['entregado'] as int) == 1, // Conversión de 1/0 a bool
    fechaPedido: DateTime.parse(json['fechaPedido'] as String),
    idUsuario: json['idUsuario'] as int,
    idProducto: json['idProducto'] as int,
  );
}

  /// Convierte un `ProductsOrderModel` en un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'idPedido': idPedido,
      'estado': estado,
      'entregado': entregado,
      'fechaPedido': fechaPedido.toIso8601String(),
      'idUsuario': idUsuario,
      'idProductos': idProducto,
    };
  }

  /// Convierte un `ProductsOrderModel` en un `FormData`
  FormData toFormData() {
    return FormData.fromMap({
      'idPedido': idPedido,
      'estado': estado,
      'entregado': entregado,
      'fechaPedido': fechaPedido.toIso8601String(),
      'idUsuario': idUsuario,
      'idProductos': idProducto,
    });
  }

  /// Convierte un `ProductsOrderModel` en una entidad del dominio `ProductsOrder`
  ProductsOrder toDomain() {
    return ProductsOrder(
      idPedido: idPedido,
      estado: estado,
      entregado: entregado,
      fechaPedido: fechaPedido,
      idUsuario: idUsuario,
      idProducto: idProducto,
    );
  }

  /// Crea una instancia de `ProductsOrderModel` desde una entidad del dominio `ProductsOrder`
  factory ProductsOrderModel.fromEntity(ProductsOrder order) {
    return ProductsOrderModel(
      idPedido: order.idPedido,
      estado: order.estado,
      entregado: order.entregado,
      fechaPedido: order.fechaPedido,
      idUsuario: order.idUsuario,
      idProducto: order.idProducto,
    );
  }
}
