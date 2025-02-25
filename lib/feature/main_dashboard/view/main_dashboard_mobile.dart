import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talentpitch_test/app/routes/routes.dart';
import 'package:talentpitch_test/feature/main_dashboard/bloc/category_bloc.dart';
import 'package:talentpitch_test/feature/video/bloc/video_bloc.dart';
import 'package:talentpitch_ui/talentpitch_ui.dart';
import 'package:flutter/material.dart';

class MainDashboardMobile extends StatelessWidget {
  MainDashboardMobile({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: AppSpacing.sm,
              ),
              Row(
                children: [
                  Text(
                    'Para ti',
                    style: UITextStyle.titles.title2Medium,
                  ),
                  SizedBox(
                    width: AppSpacing.lg,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: Text(
                        'Convocatoria',
                        style: UITextStyle.labels.label,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppSpacing.lg,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: Text(
                        'Talentos',
                        style: UITextStyle.labels.label,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppSpacing.md,
              ),
              state.category != null && state.category!.data!.isNotEmpty
                  ? Flexible(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: state.category?.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final data = state.category?.data?[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    data!.title.toString(),
                                    style: UITextStyle.titles.title2Medium,
                                  ),
                                ),
                                BaseCard(
                                  color: AppColors.black,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        child: Image.network(
                                          data.image.toString(),
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          height: 300,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return const SizedBox(
                                              width: double.infinity,
                                              height: 300,
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );
                                          },
                                          errorBuilder: (context, error, stackTrace) {
                                            return const SizedBox(
                                              width: double.infinity,
                                              height: 300,
                                              child: Center(
                                                child: Icon(Icons.broken_image, size: 50),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: AppSpacing.sm,
                                ),
                                BlocBuilder<VideoBloc, VideoState>(
                                  builder: (context, stateVideo) {
                                    return SizedBox(
                                      width: double.infinity,
                                      height: 52,
                                      child: AppButton.primary(
                                          onPressed: () {
                                            // Iniciar nuevo controlador
                                            int startIndex = data.url.toString().indexOf("categories");
                                            String result = data.url.toString().substring(startIndex);
                                            context.read<VideoBloc>().add(FetchVideosEvent(url: result));
                                            context.read<CategoryBloc>().add(UrlVideoEvent(url: data.url.toString()));
                                            context.push(RoutesNames.video);
                                          },
                                          title: 'Ver Más...'),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          );
        },
      ),
    );
  }
}
