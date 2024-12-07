class ProductsOrder {
  final int idPedido;
  final String estado;
  final bool entregado;
  final DateTime fechaPedido;
  final int idUsuario;
  final List<int> idProductos;
  
  ProductsOrder({
    required this.idPedido,
    required this.estado,
    required this.entregado,
    required this.fechaPedido,
    required this.idUsuario,
    required this.idProductos,
  });
}
