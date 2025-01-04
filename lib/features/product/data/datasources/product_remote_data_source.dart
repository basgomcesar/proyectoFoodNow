import 'package:dio/dio.dart';
import '../../../../core/utils/session.dart';
import '../models/product_model.dart';
import 'package:grpc/grpc.dart';
import '../../../../generated/productos.pbgrpc.dart';

abstract class ProductRemoteDataSource {
  Stream<ProductModel> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {

  final Dio productsSeller = Dio();
  // Eliminar la referencia a FirebaseFirestore
  final String apiUrl = 'http://localhost:3000'; // URL de tu API
  final Session session = Session.instance;

  final ClientChannel channel;
  late final ProductServiceClient client;

  ProductRemoteDataSourceImpl(this.channel) {
    client = ProductServiceClient(channel);
  }
  
  @override
  Stream<ProductModel> getProducts() async* {
    try {
      print('Getting products from server');
      final request = ProductUpdateRequest();
      final responseStream = client.subscribeToProductUpdates(request);
      await for (var product in responseStream) {
        yield ProductModel.fromGrpc(product);
      }
    } catch (e) {
      print('Error getting products: $e');
      rethrow;
    }
  }
}