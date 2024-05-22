import 'package:equatable/equatable.dart';
import 'package:festo_app/models/catalog_item.dart';
import 'package:festo_app/models/vision_search/vision_product_search_grouped_result.dart';

class VisionSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VisionSearchInitialState extends VisionSearchState {}

class VisionSearchLoadingState extends VisionSearchState {}

class VisionSearchErrorState extends VisionSearchState {
  final String errorMessage;

  VisionSearchErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class VisionSearchResultVisibleState extends VisionSearchState {
  final String sourceImageUrl;
  final List<VisionProductSearchGroupedResult> results;
  final Map<String, List<CatalogItem>> matchingCatalogItems;
  final Map<int, CatalogItem> selectedCatalogItem;

  VisionSearchResultVisibleState(
      {required this.sourceImageUrl,
      required this.results,
      required this.matchingCatalogItems,
      required this.selectedCatalogItem});

  @override
  List<Object?> get props =>
      [sourceImageUrl, results, matchingCatalogItems, selectedCatalogItem];
}

class BaseVisionSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BaseVisionSearchInitialState extends BaseVisionSearchState {}

class BaseVisionSearchLoadingState extends BaseVisionSearchState {}

class BaseVisionSearchErrorState extends BaseVisionSearchState {
  final String message;
  BaseVisionSearchErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class BaseVisionSearchResultsVisibleState extends BaseVisionSearchState {
  final String sourceImageUrl;
  final int itemCount;
  BaseVisionSearchResultsVisibleState(
      {required this.sourceImageUrl, required this.itemCount});

  @override
  List<Object?> get props => [sourceImageUrl, itemCount];
}
