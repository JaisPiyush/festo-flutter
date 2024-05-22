class AbstractItem {
  final List<String> images;
  final String name;
  final String brand_name;
  final String unit_denomination;
  final String unit_value;

  const AbstractItem(
      {required this.images,
      required this.brand_name,
      required this.name,
      required this.unit_denomination,
      required this.unit_value});
}
