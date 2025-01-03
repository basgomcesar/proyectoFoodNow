import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/product/domain/repositories/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository repository;

  DeleteProductUseCase({required this.repository});

  Future<Either<Failure, bool>> call(int idProduct) async {      
    return await repository.deleteProduct(idProduct);
    }
}