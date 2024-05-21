// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vision_product_search_grouped_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisionProductSearchGroupedResult _$VisionProductSearchGroupedResultFromJson(
        Map<String, dynamic> json) =>
    VisionProductSearchGroupedResult(
      BoundingPoly.fromJson(json['bounding_poly'] as Map<String, dynamic>),
      (json['results'] as List<dynamic>)
          .map((e) => VisionSearchProductInfoWithScore.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VisionProductSearchGroupedResultToJson(
        VisionProductSearchGroupedResult instance) =>
    <String, dynamic>{
      'bounding_poly': instance.bounding_poly,
      'results': instance.results,
    };
