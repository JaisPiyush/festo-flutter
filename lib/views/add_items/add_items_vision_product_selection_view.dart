import 'package:festo_app/bloc/add_items/add_items.cubit.dart';
import 'package:festo_app/bloc/add_items/add_items.state.dart';
import 'package:festo_app/models/catalog_item.dart';
import 'package:festo_app/views/vision_search/vision_search_view.dart';
import 'package:festo_app/views/widgets/catalog_item_card.dart';
import 'package:festo_app/views/widgets/item_card_with_bounded_box.dart';
import 'package:flutter/widgets.dart';

class AddItemsVisionProductSelectionView extends StatelessWidget {
  final AddItemsCubit cubit;
  final void Function(List<CatalogItem> items)? onNextClick;
  const AddItemsVisionProductSelectionView(
      {super.key, required this.cubit, this.onNextClick});

  @override
  Widget build(BuildContext context) {
    return VisionSearchView(
        cubit: cubit,
        showOnNext: (state) {
          return state is AddItemsVisionSearchBoundedImageVisibleState &&
              state.selectedItems.isNotEmpty;
        },
        onNext: () {
          if (onNextClick != null) {
            onNextClick!(cubit.selectedItems.values.toList());
          }
        },
        getResultCard: (context, state, index) {
          if (state is AddItemsVisionSearchBoundedImageVisibleState) {
            return ItemCardWithBoundedBox(
              key: Key(index.toString()),
              sourceImageUrl: state.sourceImageUrl,
              boundingPoly: state.boundingPolys[index],
              selectedItem: state.selectedItems[index],
              onClick: () {
                cubit.showAddItemsVisionSearchMatchingCatalogItems(
                    state.sourceImageUrl,
                    state.response,
                    index,
                    state.selectedItems[index]);
              },
            );
          } else if (state is AddItemsVisionSearchMatchingCatalogItemsVisible) {
            final item = state.selectableItems[index];
            return CatalogItemCard(
              item: item,
              isSelected: state.selectedItem == item,
              onClick: () {
                cubit.selectedItems[state.boundedImageIndex] = item;
                cubit.showAddItemsVisionSearchBoundedImage(
                    state.sourceImageUrl, state.response, cubit.selectedItems);
              },
            );
          }

          return const Placeholder();
        });
  }
}
