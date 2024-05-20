import 'package:festo_app/models/item_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'catalog_item.g.dart';

@JsonSerializable()
class CatalogItem {
  final String product_id;
  final String product_full_path;
  final String product_set_id;
  final List<ItemCategory> sub_categories;
  final String name;

  final List<String> images;
  final String brand_name;

  final bool is_selling_price_exclusive_of_gst;

  final Map<String, dynamic>? item_tax_detail;
  final String unit_denomination;
  final String unit_value;
  final List<String> product_reference_images;
  final bool is_item_group;

  final String id;

  final String? symbol;
  final String? description;
  final double? max_retail_price;
  final double? selling_price;
  final String? group_parent_item;
  final Map<String, dynamic>? item_specific_details;

  const CatalogItem(
      {required this.id,
      required this.product_id,
      required this.product_full_path,
      required this.product_set_id,
      required this.sub_categories,
      required this.name,
      required this.images,
      required this.brand_name,
      required this.is_selling_price_exclusive_of_gst,
      required this.item_tax_detail,
      required this.unit_denomination,
      required this.unit_value,
      required this.product_reference_images,
      required this.is_item_group,
      this.symbol,
      this.description,
      this.max_retail_price,
      this.selling_price,
      this.group_parent_item,
      this.item_specific_details});

  factory CatalogItem.fromJson(Map<String, dynamic> json) =>
      _$CatalogItemFromJson(json);

  Map<String, dynamic> toJson() => _$CatalogItemToJson(this);
}
