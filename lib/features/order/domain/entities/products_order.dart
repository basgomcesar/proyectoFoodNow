class ProductsOrder {
  final int idPedido;
  final String estado;
  final bool entregado;
  final DateTime fechaPedido;
  final int idUsuario;
  final int idProducto;
  
  ProductsOrder({
    required this.idPedido,
    required this.estado,
    required this.entregado,
    required this.fechaPedido,
    required this.idUsuario,
    required this.idProducto,
  });
}