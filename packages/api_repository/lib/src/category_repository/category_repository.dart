import 'package:api_helper/api_helper.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either<ApiException, CategoryModel>> getCategory({
    Map<String, String>? headers,
  });
}
