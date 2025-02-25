part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategoryEvent extends CategoryEvent {
  const GetCategoryEvent();
  @override
  List<Object> get props => [];
}

class GetVideoEvent extends CategoryEvent {
  const GetVideoEvent();
  @override
  List<Object> get props => [];
}

class UrlVideoEvent extends CategoryEvent {
  const UrlVideoEvent({required this.url});
  final String url;
  @override
  List<Object> get props => [url];
}

class AnotherVideoEvent extends CategoryEvent {
  const AnotherVideoEvent();
  @override
  List<Object> get props => [];
}
