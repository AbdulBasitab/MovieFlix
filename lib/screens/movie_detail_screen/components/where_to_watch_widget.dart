import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/watch_provider_bloc/watch_provider_bloc.dart';
import 'package:movies_app/common_widgets/image_widget.dart';
import 'package:movies_app/constants/theme_constants.dart';

class WhereToWatchWidget extends StatelessWidget {
  const WhereToWatchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchProviderBloc, WatchProviderState>(
      builder: (context, state) {
        if (state.movieWatchProvider != null &&
            state.dataStatus == DataStatus.success) {
          return SizedBox(
            height: ((state.movieWatchProvider?.buyOptions == null &&
                        state.movieWatchProvider?.rentOptions == null) ||
                    (state.movieWatchProvider?.buyOptions == null &&
                        state.movieWatchProvider?.flatrateOptions == null) ||
                    (state.movieWatchProvider?.flatrateOptions == null &&
                        state.movieWatchProvider?.rentOptions == null))
                ? 185
                : (state.movieWatchProvider?.buyOptions == null)
                    ? 350
                    : (state.movieWatchProvider?.rentOptions == null)
                        ? 350
                        : (state.movieWatchProvider?.flatrateOptions == null)
                            ? 350
                            : 530,
            child: ListView(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              children: [
                Visibility(
                  maintainState: true,
                  //  maintainAnimation: true,
                  visible: (state.movieWatchProvider?.buyOptions != null)
                      ? true
                      : false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                        ),
                        child: Text(
                          "Buy",
                          style: AppTextStyles.customTextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 0),
                      SizedBox(
                        height: 140,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemCount:
                              state.movieWatchProvider?.buyOptions?.length,
                          itemBuilder: (context, index) {
                            var buyList = state.movieWatchProvider?.buyOptions;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      child: ImageWidget(
                                        height: 80,
                                        width: 80,
                                        imageUrl:
                                            "https://image.tmdb.org/t/p/w500${buyList?[index].logoPath}",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                      buyList?[index].providerName ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.customTextStyle(
                                          fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  maintainState: true,
                  // maintainAnimation: true,
                  visible: (state.movieWatchProvider?.rentOptions != null)
                      ? true
                      : false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                        ),
                        child: Text(
                          "Rent",
                          style: AppTextStyles.customTextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 0),
                      SizedBox(
                        height: 140,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemCount:
                              state.movieWatchProvider?.rentOptions?.length,
                          itemBuilder: (context, index) {
                            var rentList =
                                state.movieWatchProvider?.rentOptions;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      // height: 120,
                                      // width: 110,
                                      child: ImageWidget(
                                          height: 80,
                                          width: 80,
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/w500${rentList?[index].logoPath}"),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: 90,
                                    child: Center(
                                      child: Text(
                                        rentList?[index].providerName ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.customTextStyle(
                                            fontSize: 13),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  maintainState: true,
                  maintainAnimation: true,
                  visible: (state.movieWatchProvider?.flatrateOptions != null)
                      ? true
                      : false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                        ),
                        child: Text(
                          "Stream",
                          style: AppTextStyles.customTextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 0),
                      SizedBox(
                        height: 140,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemCount:
                              state.movieWatchProvider?.flatrateOptions?.length,
                          itemBuilder: (context, index) {
                            var flatrateList =
                                state.movieWatchProvider?.flatrateOptions;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      // height: 120,
                                      // width: 110,
                                      child: ImageWidget(
                                          height: 80,
                                          width: 80,
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/w500${flatrateList?[index].logoPath}"),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                      flatrateList?[index].providerName ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.customTextStyle(
                                          fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state.dataStatus == DataStatus.loading) {
          return const SizedBox(
            height: 90,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.dataStatus == DataStatus.error &&
            state.movieWatchProvider == null) {
          return SizedBox(
            height: 90,
            child: Center(
              child: Text(state.errorMessage ?? 'Some Error occured',
                  textAlign: TextAlign.center),
            ),
          );
        } else {
          return SizedBox(
            height: 90,
            child: Center(
              child: Text(
                'Failed to load watch providers.',
                style: AppTextStyles.customTextStyle(fontSize: 14),
              ),
            ),
          );
        }
      },
    );
  }
}
