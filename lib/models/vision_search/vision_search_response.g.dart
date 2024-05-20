// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vision_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisionSearchResponse _$VisionSearchResponseFromJson(
        Map<String, dynamic> json) =>
    VisionSearchResponse(
      (json['results'] as List<dynamic>)
          .map((e) => VisionProductSearchGroupedResult.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      (json['product_catalog_items_map'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => CatalogItem.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$VisionSearchResponseToJson(
        VisionSearchResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'product_catalog_items_map': instance.product_catalog_items_map,
    };
