import 'package:json_annotation/json_annotation.dart';

part 'vision_search_item_single_result.g.dart';

@JsonSerializable()
class VisionSearchItemSingleResult {
  final String product_id;
  final double score;
  final String? image;

  const VisionSearchItemSingleResult(
      {required this.product_id, required this.score, required this.image});

  factory VisionSearchItemSingleResult.fromJson(Map<String, dynamic> json) =>
      _$VisionSearchItemSingleResultFromJson(json);

  Map<String, dynamic> toJson() => _$VisionSearchItemSingleResultToJson(this);
}
