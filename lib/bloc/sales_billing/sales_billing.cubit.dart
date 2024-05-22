import 'package:festo_app/bloc/sales_billing/sales_billing.state.dart';
import 'package:festo_app/models/item.dart';
import 'package:festo_app/models/vision_search/normalized_vertex.dart';
import 'package:festo_app/models/vision_search/vision_inventory_item_search_response.dart';
import 'package:festo_app/models/vision_search/vision_search_item_single_result.dart';
import 'package:festo_app/samples.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _BoundingImagesAndItemsRecord {
  final List<BoundingPoly> boundingPoly;
  final Map<int, List<Item>> matchingItems;

  const _BoundingImagesAndItemsRecord(this.boundingPoly, this.matchingItems);
}

class SalesBillingCubit extends Cubit<SalesBillingState> {
  SalesBillingCubit() : super(SalesBillingInitialState());

  late String sourceImageUrl;
  late VisionInventoryItemSearchResponse response;
  late Map<int, Item> selectedItems = {};

  _BoundingImagesAndItemsRecord getBoundingPolyToItemMapFromResponse(
      VisionInventoryItemSearchResponse response) {
    Map<int, List<Item>> matchingItems = {};
    List<BoundingPoly> polys = [];
    for (int index = 0; index < response.results.length; index++) {
      InventoryItemVisionSingleSearchResult result = response.results[index];
      polys.add(result.bounding_poly);
      List<VisionSearchItemSingleResult> products = List.from(result.results);
      products.sort((a1, a2) => a1.score.compareTo(a2.score));
      List<String> productIds =
          products.map((e) => e.product_id).toSet().toList();
      List<Item> items = [];
      productIds.forEach((productId) {
        if (response.product_id_to_items_map[productId] != null) {
          items.addAll(response.product_id_to_items_map[productId]!);
        }
      });
      matchingItems[index] = items;
    }

    return _BoundingImagesAndItemsRecord(polys, matchingItems);
  }

  void showSalesBillingVisionSearchBoundedImageWithBestMatchingItemVisible(
      String sourceImageUrl,
      VisionInventoryItemSearchResponse response,
      Map<int, Item> selectedItems_) {
    _BoundingImagesAndItemsRecord records =
        getBoundingPolyToItemMapFromResponse(response);
    if (selectedItems_.isEmpty) {
      records.matchingItems.entries.forEach((element) {
        selectedItems_[element.key] = element.value.first;
      });
    }

    selectedItems = selectedItems_;
    emit(SalesBillingVisionSearchBoundedImageWithBestMatchingItemVisible(
        sourceImageUrl: sourceImageUrl,
        response: response,
        boundingPolys: records.boundingPoly,
        boundingPolyToItemsMap: records.matchingItems,
        selectedItems: selectedItems));
  }

  void showSalesBillingVisionSearchMatchingItemsVisible(
      String sourceImageUrl,
      VisionInventoryItemSearchResponse response,
      int index,
      Item? selectedItem) {
    _BoundingImagesAndItemsRecord records =
        getBoundingPolyToItemMapFromResponse(response);
    emit(SalesBillingVisionSearchMatchingItemsVisible(
        sourceImageUrl: sourceImageUrl,
        response: response,
        boundedImageIndex: index,
        selectableItems: records.matchingItems[index]!,
        selectedItem: selectedItem));
  }

  Future<void> visionSearchItemsFromInventory(String sourceImageUrl_) async {
    sourceImageUrl = sourceImageUrl_;
    emit(SalesBillingVisionSearchingProductState(sourceImageUrl));
    response = sampleVisionInventorySearchResponse;
    //todo: implement api search
    showSalesBillingVisionSearchBoundedImageWithBestMatchingItemVisible(
        sourceImageUrl, response, selectedItems);
  }
}
