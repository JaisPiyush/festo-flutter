import 'package:festo_app/models/vision_search/normalized_vertex.dart';
import 'package:festo_app/models/vision_search/vision_search_product_info_with_score.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vision_product_search_grouped_result.g.dart';

@JsonSerializable()
class VisionProductSearchGroupedResult {
  final BoundingPoly bounding_poly;
  final List<VisionSearchProductInfoWithScore> results;

  const VisionProductSearchGroupedResult(this.bounding_poly, this.results);

  factory VisionProductSearchGroupedResult.fromJson(
          Map<String, dynamic> json) =>
      _$VisionProductSearchGroupedResultFromJson(json);

  Map<String, dynamic> toJson() =>
      _$VisionProductSearchGroupedResultToJson(this);
}
