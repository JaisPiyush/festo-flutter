// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vision_search_item_single_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisionSearchItemSingleResult _$VisionSearchItemSingleResultFromJson(
        Map<String, dynamic> json) =>
    VisionSearchItemSingleResult(
      product_id: json['product_id'] as String,
      score: (json['score'] as num).toDouble(),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$VisionSearchItemSingleResultToJson(
        VisionSearchItemSingleResult instance) =>
    <String, dynamic>{
      'product_id': instance.product_id,
      'score': instance.score,
      'image': instance.image,
    };
