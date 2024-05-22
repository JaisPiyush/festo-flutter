// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vision_inventory_item_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryItemVisionSingleSearchResult
    _$InventoryItemVisionSingleSearchResultFromJson(
            Map<String, dynamic> json) =>
        InventoryItemVisionSingleSearchResult(
          bouding_poly: BoundingPoly.fromJson(
              json['bouding_poly'] as Map<String, dynamic>),
          results: (json['results'] as List<dynamic>)
              .map((e) => VisionSearchItemSingleResult.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$InventoryItemVisionSingleSearchResultToJson(
        InventoryItemVisionSingleSearchResult instance) =>
    <String, dynamic>{
      'bouding_poly': instance.bouding_poly,
      'results': instance.results,
    };

VisionInventoryItemSearchResponse _$VisionInventoryItemSearchResponseFromJson(
        Map<String, dynamic> json) =>
    VisionInventoryItemSearchResponse(
      product_id_to_items_map:
          (json['product_id_to_items_map'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => Item.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      results: (json['results'] as List<dynamic>)
          .map((e) => InventoryItemVisionSingleSearchResult.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VisionInventoryItemSearchResponseToJson(
        VisionInventoryItemSearchResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'product_id_to_items_map': instance.product_id_to_items_map,
    };
