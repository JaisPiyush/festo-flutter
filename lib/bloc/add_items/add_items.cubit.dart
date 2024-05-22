import 'package:festo_app/bloc/add_items/add_items.state.dart';
import 'package:festo_app/models/catalog_item.dart';
import 'package:festo_app/models/item.dart';
import 'package:festo_app/models/vision_search/normalized_vertex.dart';
import 'package:festo_app/models/vision_search/vision_search_product_info_with_score.dart';
import 'package:festo_app/models/vision_search/vision_search_response.dart';
import 'package:festo_app/samples.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _BoundingImagesAndCatalogItemsRecord {
  final List<BoundingPoly> boundingPoly;
  final Map<int, List<CatalogItem>> matchingItems;

  const _BoundingImagesAndCatalogItemsRecord(
      this.boundingPoly, this.matchingItems);
}

class AddItemsCubit extends Cubit<AddItemsState> {
  AddItemsCubit() : super(AddItemsInitialState());

  late String sourceImageUrl;
  late VisionSearchResponse response;
  late Map<int, CatalogItem> selectedItems = {};

  _BoundingImagesAndCatalogItemsRecord
      getBoundingPolyToCatalogItemMapFromResponse(
          VisionSearchResponse response) {
    List<BoundingPoly> polys = [];
    Map<int, List<CatalogItem>> matchingItems = {};

    for (int index = 0; index < response.results.length; index++) {
      final result = response.results[index];
      polys.add(result.bounding_poly);

      List<VisionSearchProductInfoWithScore> products =
          List.from(result.results);
      products.sort((a1, a2) => a1.score.compareTo(a2.score));
      List<String> productIds =
          products.map((e) => e.product.product_id).toSet().toList();
      List<CatalogItem> items = [];
      productIds.forEach((productId) {
        if (response.product_catalog_items_map[productId] != null) {
          items.addAll(response.product_catalog_items_map[productId]!);
        }
      });
      matchingItems[index] = items;
    }

    return _BoundingImagesAndCatalogItemsRecord(polys, matchingItems);
  }

  void showAddItemsVisionSearchBoundedImage(String sourceImageUrl,
      VisionSearchResponse response, Map<int, CatalogItem> selectedItems_) {
    _BoundingImagesAndCatalogItemsRecord records =
        getBoundingPolyToCatalogItemMapFromResponse(response);
    if (selectedItems_.isEmpty) {
      records.matchingItems.entries.forEach((element) {
        selectedItems_[element.key] = element.value.first;
      });
    }
    selectedItems = selectedItems_;
    emit(AddItemsVisionSearchBoundedImageVisibleState(
        sourceImageUrl: sourceImageUrl,
        response: response,
        boundingPolys: records.boundingPoly,
        boundingPolyToItemsMap: records.matchingItems,
        selectedItems: selectedItems));
  }

  void showAddItemsVisionSearchMatchingCatalogItems(String sourceImageUrl,
      VisionSearchResponse response, int index, CatalogItem? selectedItem) {
    _BoundingImagesAndCatalogItemsRecord records =
        getBoundingPolyToCatalogItemMapFromResponse(response);
    emit(AddItemsVisionSearchMatchingCatalogItemsVisible(
        sourceImageUrl: sourceImageUrl,
        response: response,
        boundedImageIndex: index,
        selectableItems: records.matchingItems[index]!,
        selectedItem: selectedItem));
  }

  Future<void> visionSearchItemFromGlobalCatalog(String sourceImageUrl_) async {
    sourceImageUrl = sourceImageUrl_;
    emit(AddItemsVisionSearchState());
    response = sampleVisionSearchResponse;
    //todo: implement api search
    showAddItemsVisionSearchBoundedImage(
        sourceImageUrl, response, selectedItems);
  }

  void showInventoryMutationForms() {
    emit(AddItemsInventoryMutationFormVisible(selectedItems.values.toList()));
  }

  Future<void> addItemsToInventory(List<Item> items) async {
    emit(AddItemsInventoryMutationState());
    try {
      //todo: implement add inventory api
      emit(AddItemsInventoryMutationCompletedState());
    } catch (_) {
      emit(AddItemsInventoryMutationFailedState(
          'Unknown error while creating items'));
    }
  }
}
