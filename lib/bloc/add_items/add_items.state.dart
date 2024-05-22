// ignore_for_file: must_be_immutable

import 'package:festo_app/bloc/vision_search/vision_search.state.dart';
import 'package:festo_app/models/catalog_item.dart';
import 'package:festo_app/models/vision_search/normalized_vertex.dart';
import 'package:festo_app/models/vision_search/vision_search_response.dart';

class AddItemsState extends BaseVisionSearchState {}

class AddItemsInitialState extends AddItemsState {}

class AddItemsLoadingState extends AddItemsState {}

class AddItemsVisionSearchState extends AddItemsState
    with BaseVisionSearchInitialMixin {}

class AddItemsErrorState extends AddItemsVisionSearchState
    with BaseVisionSearchErrorMixin {
  @override
  final String message;
  AddItemsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class AddItemsVisionSearchingProductState extends AddItemsVisionSearchState
    with BaseVisionSearchLoadingMixin {
  final String sourceImageUrl;
  AddItemsVisionSearchingProductState(this.sourceImageUrl);

  @override
  List<Object?> get props => [sourceImageUrl];
}

class AddItemsVisionSearchResultsVisibleState extends AddItemsVisionSearchState
    with BaseVisionSearchResultsVisibleMixin {
  final String sourceImageUrl;
  final VisionSearchResponse response;
  AddItemsVisionSearchResultsVisibleState(
      {required this.sourceImageUrl, required this.response}) {
    itemCount = response.results.length;
  }

  @override
  List<Object?> get props => [sourceImageUrl, response, itemCount];
}

class AddItemsVisionSearchBoundedImageVisibleState
    extends AddItemsVisionSearchResultsVisibleState {
  final List<BoundingPoly> boundingPolys;
  final Map<int, List<CatalogItem>> boundingPolyToItemsMap;
  final Map<int, CatalogItem> selectedItems;

  AddItemsVisionSearchBoundedImageVisibleState(
      {required super.sourceImageUrl,
      required super.response,
      required this.boundingPolys,
      required this.boundingPolyToItemsMap,
      required this.selectedItems}) {
    itemCount = boundingPolys.length;
  }
  @override
  List<Object?> get props => [
        sourceImageUrl,
        response,
        boundingPolys,
        itemCount,
        boundingPolyToItemsMap,
        selectedItems
      ];
}

class AddItemsVisionSearchMatchingCatalogItemsVisible
    extends AddItemsVisionSearchResultsVisibleState {
  final int boundedImageIndex;
  final List<CatalogItem> selectableItems;
  final CatalogItem? selectedItem;

  AddItemsVisionSearchMatchingCatalogItemsVisible(
      {required super.sourceImageUrl,
      required super.response,
      required this.boundedImageIndex,
      required this.selectableItems,
      required this.selectedItem}) {
    itemCount = selectableItems.length;
  }

  @override
  List<Object?> get props => [
        sourceImageUrl,
        response,
        itemCount,
        boundedImageIndex,
        selectableItems,
        selectedItem
      ];
}

class AddItemsInventoryMutationState extends AddItemsState {}

class AddItemsInventoryMutationFormVisible
    extends AddItemsInventoryMutationState {
  final List<CatalogItem> items;
  AddItemsInventoryMutationFormVisible(this.items);
}

class AddItemsInventoryMutationInProgressState
    extends AddItemsInventoryMutationState {}

class AddItemsInventoryMutationCompletedState
    extends AddItemsInventoryMutationState {}

class AddItemsInventoryMutationFailedState extends AddItemsErrorState {
  AddItemsInventoryMutationFailedState(super.message);
}
