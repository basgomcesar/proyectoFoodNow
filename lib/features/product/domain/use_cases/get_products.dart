import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../../../core/error/failure.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts({required this.repository});

  Stream<Either<Failure, Product>> call() {
    return repository.getProducts();
  }
}
