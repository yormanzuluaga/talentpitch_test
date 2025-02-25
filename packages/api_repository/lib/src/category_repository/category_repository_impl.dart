import 'package:api_helper/api_helper.dart';
import 'package:api_repository/api_repository.dart';
import 'package:dartz/dartz.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  CategoryResource categoryResource;
  @override
  CategoryRepositoryImpl({
    required this.categoryResource,
  });

  @override
  Future<Either<ApiException, CategoryModel>> getCategory({
    Map<String, String>? headers,
  }) async {
    final movieModel = await categoryResource.getCategory(
      headers: headers,
    );
    return movieModel.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
