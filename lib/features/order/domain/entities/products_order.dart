class ProductOrder {
  final int idPedido;
  final String estadoPedido;
  final DateTime fechaPedido;
  final int idCliente;
  final int idProducto;
  final String nombreCliente;
  final String nombreVendedor;
  final int cantidad;

  ProductOrder({
    required this.idPedido,
    required this.estadoPedido,
    required this.fechaPedido,
    required this.idCliente,
    required this.idProducto,
    required this.nombreCliente,
    required this.nombreVendedor,
    required this.cantidad,
  });
}
