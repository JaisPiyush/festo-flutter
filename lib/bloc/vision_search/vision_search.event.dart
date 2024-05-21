import 'package:equatable/equatable.dart';
import 'package:festo_app/models/catalog_item.dart';

class VisionSearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class VisionSearchFetchResultsEvent extends VisionSearchEvent {}

class VisionSearchSelectCatalogItemEvent extends VisionSearchEvent {
  final Map<int, CatalogItem> selectedCatalogItem;

  VisionSearchSelectCatalogItemEvent(this.selectedCatalogItem);

  @override
  List<Object?> get props => [selectedCatalogItem];
}
