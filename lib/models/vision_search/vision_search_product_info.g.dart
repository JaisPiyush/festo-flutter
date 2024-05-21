// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vision_search_product_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisionSearchProductInfo _$VisionSearchProductInfoFromJson(
        Map<String, dynamic> json) =>
    VisionSearchProductInfo(
      name: json['name'] as String,
      product_id: json['product_id'] as String,
      display_name: json['display_name'] as String,
      product_category: json['product_category'] as String?,
      product_labels: (json['product_labels'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$VisionSearchProductInfoToJson(
        VisionSearchProductInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'product_id': instance.product_id,
      'display_name': instance.display_name,
      'product_category': instance.product_category,
      'product_labels': instance.product_labels,
    };
