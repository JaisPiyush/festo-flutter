import 'package:json_annotation/json_annotation.dart';

part 'item_category.g.dart';

@JsonSerializable()
class ItemCategory {
  final String id;
  final String? parent;
  final String name;

  const ItemCategory({required this.id, required this.name, this.parent});

  factory ItemCategory.fromJson(Map<String, dynamic> json) =>
      _$ItemCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ItemCategoryToJson(this);
}
