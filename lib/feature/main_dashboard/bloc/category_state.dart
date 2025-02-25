// ignore_for_file: must_be_immutable

part of 'category_bloc.dart';

class CategoryState extends Equatable {
  const CategoryState({
    this.category,
    this.url = '',
  });

  final CategoryModel? category;
  final String url;

  CategoryState copyWith({
    CategoryModel? category,
    String? url,
  }) {
    return CategoryState(
      category: category ?? this.category,
      url: url ?? this.url,
    );
  }

  @override
  List<Object?> get props => [
        category,
        url,
      ];
}
