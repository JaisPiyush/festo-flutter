import 'package:dio/dio.dart';
import 'package:festo_app/api/catalog_item.dart';
import 'package:festo_app/api/client.dart';
import 'package:festo_app/bloc/vision_search/vision_search.state.dart';
import 'package:festo_app/models/catalog_item.dart';
import 'package:festo_app/models/vision_search/vision_product_search_grouped_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisionSearchCubit extends Cubit<VisionSearchState> {
  VisionSearchCubit(this.sourceImageUrl, ApiClient client)
      : super(VisionSearchInitialState()) {
    catalogItemAPIClient = CatalogItemAPIClient(client);
  }

  final String sourceImageUrl;
  late CatalogItemAPIClient catalogItemAPIClient;

  List<VisionProductSearchGroupedResult> results = [];
  Map<String, List<CatalogItem>> productIdMatchingCatalogItems = {};
  Map<int, CatalogItem> selectedCatalogItem = {};

  Future<void> visionSearch() async {
    emit(VisionSearchLoadingState());
    try {
      final res = await catalogItemAPIClient.visionSearch(sourceImageUrl);
      results = res.results;
      productIdMatchingCatalogItems = res.product_catalog_items_map;
      selectedCatalogItem = {};
      emit(VisionSearchResultVisibleState(
          sourceImageUrl: sourceImageUrl,
          results: results,
          matchingCatalogItems: productIdMatchingCatalogItems,
          selectedCatalogItem: selectedCatalogItem));
    } on DioException catch (error) {
      emit(VisionSearchErrorState(
          error.response?.data?.error ?? 'Unknown error'));
    }
  }

  void selectCatalogItems(Map<int, CatalogItem> selectedCatalogItem_) {
    selectedCatalogItem.addAll(selectedCatalogItem_);
    emit(VisionSearchResultVisibleState(
        sourceImageUrl: sourceImageUrl,
        results: results,
        matchingCatalogItems: productIdMatchingCatalogItems,
        selectedCatalogItem: selectedCatalogItem));
  }
}
