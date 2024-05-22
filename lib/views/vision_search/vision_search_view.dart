import 'package:festo_app/bloc/vision_search/vision_search.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisionSearchView<S extends BaseVisionSearchState>
    extends StatelessWidget {
  final Cubit<S> cubit;
  final Widget Function(BuildContext context, S state, int index) getResultCard;
  final bool Function(S state)? showOnNext;
  final VoidCallback? onNext;
  const VisionSearchView(
      {super.key,
      required this.cubit,
      required this.getResultCard,
      this.showOnNext,
      this.onNext});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<Cubit<S>, S>(
      bloc: cubit,
      builder: (context, state) {
        if (state is BaseVisionSearchErrorMixin) {
          final snack = SnackBar(content: Text(state.message));
          ScaffoldMessenger.of(context).showSnackBar(snack);
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
                          getResultCard(context, state, index))),
              if (onNext != null && showOnNext != null && showOnNext!(state))
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                onNext!();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.primaryColor,
                                  foregroundColor: theme.colorScheme.background,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: Text('Continue')))
                    ],
                  ),
                )
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
