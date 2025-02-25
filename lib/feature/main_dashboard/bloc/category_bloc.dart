import 'package:api_helper/api_helper.dart';
import 'package:api_repository/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talentpitch_test/app/routes/router_config.dart';
import 'package:talentpitch_test/app/routes/routes_names.dart';
import 'package:talentpitch_test/feature/video/bloc/video_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required CategoryRepository categoryRepository,
  })  : _categoryRepository = categoryRepository,
        super(CategoryState()) {
    on<CategoryEvent>((event, emit) {});

    on<GetCategoryEvent>((event, emit) async {
      final result = await _categoryRepository.getCategory();

      result.fold((l) {}, (r) {
        emit(state.copyWith(category: r));
      });
    });
    on<UrlVideoEvent>((event, emit) => emit(state.copyWith(url: event.url)));
    on<AnotherVideoEvent>((event, emit) {
      for (var i = 0; i < (state.category?.data?.length ?? 0); i++) {
        if (state.category!.data![i].url == state.url) {
          int startIndex = state.category!.data![i + 1].url.toString().indexOf("categories");
          String result = state.category!.data![i + 1].url.toString().substring(startIndex);
          rootNavigatorKey.currentContext!.read<VideoBloc>().add(FetchVideosEvent(url: result));
          Future.delayed(Duration(seconds: 1), () {
            rootNavigatorKey.currentContext!
              ..pop()
              ..push(RoutesNames.video);
          });

          emit(state.copyWith(url: state.category!.data![i + 1].url.toString()));
        }
      }
    });
  }
  final CategoryRepository _categoryRepository;
}
