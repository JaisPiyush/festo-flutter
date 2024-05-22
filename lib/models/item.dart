import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  final String product_id;
  final String product_full_path;
  final String product_set_id;
  final List<String> sub_categories;
  final String name;

  final List<String> images;
  final String brand_name;

  final bool is_selling_price_exclusive_of_gst;

  final String unit_denomination;
  final String unit_value;
  final String id;
  final bool is_returnable;
  final String seller;
  final double quantity;

  final String? symbol;
  final String? description;
  final double? max_retail_price;
  final double? selling_price;
  final Map<String, dynamic>? item_specific_details;
  final Map<String, dynamic>? item_tax_detail;
  final double? reorder_level;

  const Item(
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
      required this.is_returnable,
      required this.seller,
      required this.quantity,
      this.symbol,
      this.description,
      this.max_retail_price,
      this.selling_price,
      this.reorder_level,
      this.item_specific_details});

  factory Item.fromJson(Map<String, dynamic> json) {
    json['double'] = double.parse(json['double']);
    json['max_retail_price'] ??= double.parse(json['max_retail_price']);
    json['selling_price'] ??= double.parse(json['selling_price']);
    json['reorder_level'] ??= double.parse(json['reorder_level']);

    return _$ItemFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
