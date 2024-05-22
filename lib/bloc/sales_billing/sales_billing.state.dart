// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:festo_app/bloc/vision_search/vision_search.state.dart';
import 'package:festo_app/models/item.dart';
import 'package:festo_app/models/vision_search/normalized_vertex.dart';
import 'package:festo_app/models/vision_search/vision_inventory_item_search_response.dart';

class SalesBillingState extends BaseVisionSearchState {}

class SalesBillingInitialState extends SalesBillingState {}

class SalesBillingLoadingState extends SalesBillingState {}

class SalesBillingImagePickerVisibleState extends SalesBillingState {}

class SalesBillingVisionSearchState extends SalesBillingState
    with BaseVisionSearchInitialMixin {}

class SalesBillingErrorState extends SalesBillingVisionSearchState
    with BaseVisionSearchErrorMixin {
  @override
  final String message;
  SalesBillingErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class SalesBillingVisionSearchingProductState
    extends SalesBillingVisionSearchState with BaseVisionSearchLoadingMixin {
  final String sourceImageUrl;
  SalesBillingVisionSearchingProductState(this.sourceImageUrl);

  @override
  List<Object?> get props => [sourceImageUrl];
}

class SalesBillingVisionSearchResultsVisibleState
    extends SalesBillingVisionSearchState
    with BaseVisionSearchResultsVisibleMixin {
  final String sourceImageUrl;
  final VisionInventoryItemSearchResponse response;

  SalesBillingVisionSearchResultsVisibleState(
      {required this.sourceImageUrl, required this.response}) {
    itemCount = response.results.length;
  }

  @override
  List<Object?> get props => [sourceImageUrl, response, itemCount];
}

class SalesBillingVisionSearchBoundedImageWithBestMatchingItemVisible
    extends SalesBillingVisionSearchResultsVisibleState {
  final List<BoundingPoly> boundingPolys;
  final Map<int, List<Item>> boundingPolyToItemsMap;
  final Map<int, Item> selectedItems;

  SalesBillingVisionSearchBoundedImageWithBestMatchingItemVisible({
    required super.sourceImageUrl,
    required super.response,
    required this.boundingPolys,
    required this.boundingPolyToItemsMap,
    required this.selectedItems,
  }) {
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

class SalesBillingVisionSearchMatchingItemsVisible
    extends SalesBillingVisionSearchResultsVisibleState {
  final int boundedImageIndex;
  final List<Item> selectableItems;
  final Item? selectedItem;
  SalesBillingVisionSearchMatchingItemsVisible(
      {required super.sourceImageUrl,
      required super.response,
      required this.boundedImageIndex,
      required this.selectableItems,
      this.selectedItem}) {
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

class SalesBillingVoucherFormVisibleState extends SalesBillingState {
  final List<Item> items;
  SalesBillingVoucherFormVisibleState(this.items);

  @override
  List<Object?> get props => [items];
}

class SalesBillingVoucherCreationCompleted extends SalesBillingState {}
