import 'package:json_annotation/json_annotation.dart';

part 'vision_search_product_info.g.dart';

@JsonSerializable()
class VisionSearchProductInfo {
  final String name;
  final String product_id;
  final String display_name;
  final String? product_category;
  final List<Map<String, dynamic>>? product_labels;

  const VisionSearchProductInfo(
      {required this.name,
      required this.product_id,
      required this.display_name,
      required this.product_category,
      this.product_labels});

  factory VisionSearchProductInfo.fromJson(Map<String, dynamic> json) =>
      _$VisionSearchProductInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VisionSearchProductInfoToJson(this);
}
