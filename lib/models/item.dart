import 'package:json_annotation/json_annotation.dart';

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

  Item.fromJson(Map<String, dynamic> json)
      : product_id = json['product_id'],
        product_full_path = json['product_full_path'],
        product_set_id = json['product_set_id'],
        sub_categories = json['sub_categories'],
        name = json['name'],
        images = json['images'],
        brand_name = json['brand_name'],
        is_selling_price_exclusive_of_gst =
            json['is_selling_price_exclusive_of_gst'],
        unit_denomination = json['unit_denomination'],
        unit_value = json['unit_value'],
        id = json['id'],
        is_returnable = json['is_returnable'],
        seller = json['seller'],
        quantity = double.parse(json['quantity']),
        symbol = json['symbol'],
        description = json['description'],
        max_retail_price = double.parse(json['max_retail_price'] ?? '0'),
        selling_price = double.parse(json['selling_price'] ?? '0'),
        item_specific_details = json['item_specific_details'],
        item_tax_detail = json['item_tax_detail'],
        reorder_level = double.parse(json['reorder_level'] ?? '0');

  Map<String, dynamic> toJson() => {
        "product_id": product_id,
        "product_full_path": product_full_path,
        "product_set_id": product_set_id,
        "sub_categories": sub_categories,
        "name": name,
        "images": images,
        "brand_name": brand_name,
        "is_selling_price_exclusive_of_gst": is_selling_price_exclusive_of_gst,
        "unit_denomination": unit_denomination,
        "unit_value": unit_value,
        "id": id,
        "is_returnable": is_returnable,
        "seller": seller,
        "quantity": quantity,
        "symbol": symbol,
        "description": description,
        "max_retail_price": max_retail_price,
        "selling_price": selling_price,
        "item_specific_details": item_specific_details,
        "item_tax_detail": item_tax_detail,
        "reorder_level": reorder_level
      };
}
