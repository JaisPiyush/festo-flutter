// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as String?,
      product_id: json['product_id'] as String,
      product_full_path: json['product_full_path'] as String,
      product_set_id: json['product_set_id'] as String,
      sub_categories: (json['sub_categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      name: json['name'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      brand_name: json['brand_name'] as String,
      is_selling_price_exclusive_of_gst:
          json['is_selling_price_exclusive_of_gst'] as bool,
      item_tax_detail: json['item_tax_detail'] as Map<String, dynamic>?,
      unit_denomination: json['unit_denomination'] as String,
      unit_value: json['unit_value'] as String,
      is_returnable: json['is_returnable'] as bool,
      seller: json['seller'] as String?,
      quantity: (json['quantity'] as num).toDouble(),
      symbol: json['symbol'] as String?,
      description: json['description'] as String?,
      max_retail_price: (json['max_retail_price'] as num?)?.toDouble(),
      selling_price: (json['selling_price'] as num?)?.toDouble(),
      reorder_level: (json['reorder_level'] as num?)?.toDouble(),
      item_specific_details:
          json['item_specific_details'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'images': instance.images,
      'name': instance.name,
      'brand_name': instance.brand_name,
      'unit_denomination': instance.unit_denomination,
      'unit_value': instance.unit_value,
      'product_id': instance.product_id,
      'product_full_path': instance.product_full_path,
      'product_set_id': instance.product_set_id,
      'sub_categories': instance.sub_categories,
      'is_selling_price_exclusive_of_gst':
          instance.is_selling_price_exclusive_of_gst,
      'id': instance.id,
      'is_returnable': instance.is_returnable,
      'seller': instance.seller,
      'quantity': instance.quantity,
      'symbol': instance.symbol,
      'description': instance.description,
      'max_retail_price': instance.max_retail_price,
      'selling_price': instance.selling_price,
      'item_specific_details': instance.item_specific_details,
      'item_tax_detail': instance.item_tax_detail,
      'reorder_level': instance.reorder_level,
    };
