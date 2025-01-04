import 'package:dartz/dartz.dart';
import 'package:loging_app/features/product/domain/entities/product_graph.dart';
import '../../../../core/error/failure.dart';
import '../repositories/product_offered_repository.dart';

class GetProductsOfferedUseCase {
  final ProductOfferedRepository repository;

  GetProductsOfferedUseCase({required this.repository});

  Future<Either<Failure, List<ProductGraph>>> call(String userId, String anio, String mes) async {      
    return await repository.getProductsOffered(userId, anio, mes);   
  }
}