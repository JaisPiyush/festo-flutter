import 'package:festo_app/bloc/vision_search/vision_search.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisionSearchView<S extends BaseVisionSearchState>
    extends StatelessWidget {
  final Cubit<S> cubit;
  final Widget Function(BuildContext context, S state, int index) getResultCard;
  const VisionSearchView(
      {super.key, required this.cubit, required this.getResultCard});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<Cubit<S>, S>(
      bloc: cubit,
      builder: (context, state) {
        if (state is BaseVisionSearchErrorMixin) {
          return Center(
            child: Text(
              state.message,
              style: theme.textTheme.bodyMedium!.copyWith(color: Colors.red),
            ),
          );
        } else if (state is BaseVisionSearchResultsVisibleMixin) {
          return Column(
            children: [
              Expanded(
                  child: GridView.builder(
                      itemCount: state.itemCount,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 12),
                      itemBuilder: (context, index) =>
                          getResultCard(context, state, index)))
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}


// typedef OnNextClickFunction = void Function(BuildContext context);
// typedef GetProductCardWidget = Widget Function(
//     BuildContext context,
//     String sourceImageUrl,
//     int resultIndex,
//     VisionProductSearchGroupedResult result,
//     Map<String, List<CatalogItem>> matchingCatalogItems,
//     [CatalogItem? selectedCatalogItem]);

// class VisionSearchView extends StatelessWidget {
//   final String sourceImageUrl;
//   final OnNextClickFunction onNextClick;
//   final GetProductCardWidget getProductCardWidget;
//   const VisionSearchView(
//       {super.key,
//       required this.sourceImageUrl,
//       required this.onNextClick,
//       required this.getProductCardWidget});

//   @override
//   Widget build(BuildContext context) {
//     final client = RepositoryProvider.of<ApiClient>(context);
//     final cubit = VisionSearchCubit(sourceImageUrl, client);

//     return RepositoryProvider(
//       create: (context) {
//         cubit.visionSearch();
//         return cubit;
//       },
//       child: _VisionSearchViewBlocConsumer(
//           onNextClick: onNextClick, getProductCardWidget: getProductCardWidget),
//     );
//   }
// }

// class _VisionSearchViewBlocConsumer extends StatelessWidget {
//   final OnNextClickFunction onNextClick;
//   final GetProductCardWidget getProductCardWidget;
//   const _VisionSearchViewBlocConsumer(
//       {super.key,
//       required this.onNextClick,
//       required this.getProductCardWidget});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       child: BlocBuilder<VisionSearchCubit, VisionSearchState>(
//           bloc: RepositoryProvider.of<VisionSearchCubit>(context),
//           builder: (context, state) {
            // if (state is VisionSearchErrorState) {
            //   return Center(
            //     child: Text(
            //       state.errorMessage,
            //       style:
            //           theme.textTheme.bodyMedium!.copyWith(color: Colors.red),
            //     ),
            //   );
            // } else if (state is VisionSearchResultVisibleState) {
//               return Column(
//                 children: [
//                   Expanded(
//                     child: GridView.builder(
//                       itemCount: state.results.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2),
//                       itemBuilder: (context, index) {
//                         return getProductCardWidget(
//                             context,
//                             state.sourceImageUrl,
//                             index,
//                             state.results[index],
//                             state.matchingCatalogItems,
//                             state.selectedCatalogItem[index]);
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Row(
//                       children: [
//                         Expanded(
//                             child: ElevatedButton(
//                                 onPressed: () {
//                                   onNextClick(context);
//                                 },
//                                 child: const Text('Continue')))
//                       ],
//                     ),
//                   )
//                 ],
//               );
//             }
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }),
//     );
//   }
// }
