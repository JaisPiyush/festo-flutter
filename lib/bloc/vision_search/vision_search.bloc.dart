import 'package:dio/dio.dart';
import 'package:festo_app/api/catalog_item.dart';
import 'package:festo_app/api/client.dart';
import 'package:festo_app/bloc/vision_search/vision_search.event.dart';
import 'package:festo_app/bloc/vision_search/vision_search.state.dart';
import 'package:festo_app/models/catalog_item.dart';
import 'package:festo_app/models/vision_search/vision_product_search_grouped_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisionSearchBloc extends Bloc<VisionSearchEvent, VisionSearchState> {
  VisionSearchBloc(this.sourceImageUrl, ApiClient _client)
      : super(VisionSearchInitialState()) {
    client = CatalogItemAPIClient(_client);
    on<VisionSearchFetchResultsEvent>(_onVisionSearchFetchResultsEvent);
    on<VisionSearchSelectCatalogItemEvent>(
        _onVisionSearchSelectCatalogItemEvent);
  }

  final String sourceImageUrl;
  late final CatalogItemAPIClient client;

  List<VisionProductSearchGroupedResult> results = [];
  Map<String, List<CatalogItem>> productIdMatchingCatalogItems = {};
  Map<int, CatalogItem> selectedCatalogItem = {};

  Future<void> _onVisionSearchFetchResultsEvent(
      VisionSearchFetchResultsEvent e, Emitter<VisionSearchState> emit) async {
    emit(VisionSearchLoadingState());
    try {
      final res = await client.visionSearch(sourceImageUrl);
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

  Future<void> _onVisionSearchSelectCatalogItemEvent(
      VisionSearchSelectCatalogItemEvent e,
      Emitter<VisionSearchState> emit) async {
    selectedCatalogItem.addAll(e.selectedCatalogItem);
    emit(VisionSearchResultVisibleState(
        sourceImageUrl: sourceImageUrl,
        results: results,
        matchingCatalogItems: productIdMatchingCatalogItems,
        selectedCatalogItem: selectedCatalogItem));
  }
}
