// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vision_search_product_info_with_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisionSearchProductInfoWithScore _$VisionSearchProductInfoWithScoreFromJson(
        Map<String, dynamic> json) =>
    VisionSearchProductInfoWithScore(
      product: VisionSearchProductInfo.fromJson(
          json['product'] as Map<String, dynamic>),
      score: (json['score'] as num).toDouble(),
      image: json['image'] as String,
    );

Map<String, dynamic> _$VisionSearchProductInfoWithScoreToJson(
        VisionSearchProductInfoWithScore instance) =>
    <String, dynamic>{
      'product': instance.product,
      'score': instance.score,
      'image': instance.image,
    };
