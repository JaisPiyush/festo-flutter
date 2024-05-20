import 'package:festo_app/models/vision_search/vision_search_product_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vision_search_product_info_with_score.g.dart';

@JsonSerializable()
class VisionSearchProductInfoWithScore {
  final VisionSearchProductInfo product;
  final double score;
  final String image;

  const VisionSearchProductInfoWithScore(
      {required this.product, required this.score, required this.image});

  factory VisionSearchProductInfoWithScore.fromJson(Map<String, dynamic> json) {
    json['score'] = double.parse(json['score']);
    return _$VisionSearchProductInfoWithScoreFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$VisionSearchProductInfoWithScoreToJson(this);
}
