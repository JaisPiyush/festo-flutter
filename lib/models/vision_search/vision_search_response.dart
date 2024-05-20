import 'package:festo_app/models/catalog_item.dart';
import 'package:festo_app/models/vision_search/vision_product_search_grouped_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vision_search_response.g.dart';

@JsonSerializable()
class VisionSearchResponse {
  final List<VisionProductSearchGroupedResult> results;
  final Map<String, List<CatalogItem>> product_catalog_items_map;

  const VisionSearchResponse(this.results, this.product_catalog_items_map);

  factory VisionSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$VisionSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VisionSearchResponseToJson(this);
}
