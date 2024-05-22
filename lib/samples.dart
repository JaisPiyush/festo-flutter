import 'package:festo_app/models/catalog_item.dart';
import 'package:festo_app/models/item.dart';
import 'package:festo_app/models/item_category.dart';
import 'package:festo_app/models/vision_search/normalized_vertex.dart';
import 'package:festo_app/models/vision_search/vision_product_search_grouped_result.dart';
import 'package:festo_app/models/vision_search/vision_search_product_info.dart';
import 'package:festo_app/models/vision_search/vision_search_product_info_with_score.dart';
import 'package:festo_app/models/vision_search/vision_search_response.dart';

List<Item> sampleItems = [
  const Item(
    product_id: '001',
    product_full_path: '/groceries/vegetables/tomato',
    product_set_id: 'V001',
    sub_categories: ['vegetables', 'fresh produce'],
    name: 'Seared Scallops with Quinoa',
    images: [
      'https://storage.googleapis.com/vyser-product-database/kissan-fresh-tomato-ketchup/20240517_132710.png'
    ],
    brand_name: 'Farm Fresh',
    is_selling_price_exclusive_of_gst: true,
    unit_denomination: 'kg',
    unit_value: '1',
    id: 'ITM001',
    is_returnable: true,
    seller: 'Local Farmer',
    quantity: 100.0,
    symbol: '₹',
    description: 'Fresh red tomatoes',
    max_retail_price: 40.0,
    selling_price: 35.0,
    item_specific_details: {'organic': true},
    item_tax_detail: {'GST': 5},
    reorder_level: 10.0,
  ),
  const Item(
    product_id: '002',
    product_full_path: '/groceries/fruits/apple',
    product_set_id: 'F001',
    sub_categories: ['fruits', 'fresh produce'],
    name: 'Caesar salad croquettes',
    images: [
      'https://storage.googleapis.com/vyser-product-database/kurkure-masala-munch-crisps/20240517_132915.png'
    ],
    brand_name: 'Orchard Fresh',
    is_selling_price_exclusive_of_gst: true,
    unit_denomination: 'kg',
    unit_value: '1',
    id: 'ITM002',
    is_returnable: true,
    seller: 'Orchard Supplier',
    quantity: 200.0,
    symbol: '₹',
    description: 'Crisp and sweet apples',
    max_retail_price: 120.0,
    selling_price: 110.0,
    item_specific_details: {'imported': false},
    item_tax_detail: {'GST': 5},
    reorder_level: 20.0,
  ),
  const Item(
    product_id: '003',
    product_full_path: '/groceries/dairy/milk',
    product_set_id: 'D001',
    sub_categories: ['dairy', 'beverages'],
    name: 'Croque de luxe meat steak',
    images: [
      'https://storage.googleapis.com/vyser-product-database/tang-instant-drink-mix-orange/20240517_132833.png'
    ],
    brand_name: 'Dairy Best',
    is_selling_price_exclusive_of_gst: true,
    unit_denomination: 'litre',
    unit_value: '1',
    id: 'ITM003',
    is_returnable: false,
    seller: 'Dairy Farm',
    quantity: 500.0,
    symbol: '₹',
    description: 'Pure and fresh milk',
    max_retail_price: 50.0,
    selling_price: 45.0,
    item_specific_details: {'fat_content': '3.5%'},
    item_tax_detail: {'GST': 5},
    reorder_level: 50.0,
  ),
];

List<CatalogItem> catalogItems = [
  const CatalogItem(
    id: 'C001',
    product_id: 'P001',
    product_full_path: '/electronics/phone',
    product_set_id: 'SET001',
    sub_categories: [
      ItemCategory(id: 'IC001', name: 'Electronics'),
      ItemCategory(id: 'IC002', name: 'Mobile Phones', parent: 'IC001'),
    ],
    name: 'Seared Scallops with Quinoa',
    images: [
      'https://storage.googleapis.com/vyser-product-database/kissan-fresh-tomato-ketchup/20240517_132710.png'
    ],
    brand_name: 'TechBrand',
    is_selling_price_exclusive_of_gst: true,
    item_tax_detail: {'GST': 18},
    unit_denomination: 'gm',
    unit_value: '250',
    product_reference_images: ['ref_phone1.jpg'],
    is_item_group: false,
    symbol: '₹',
    description: 'Latest model smartphone with advanced features',
    max_retail_price: 50000.0,
    selling_price: 45000.0,
    group_parent_item: null,
    item_specific_details: {'color': 'Black', 'storage': '128GB'},
  ),
  const CatalogItem(
    id: 'C003',
    product_id: 'P002',
    product_full_path: '/home/kitchen',
    product_set_id: 'SET002',
    sub_categories: [
      ItemCategory(id: 'IC003', name: 'Home Appliances'),
      ItemCategory(id: 'IC004', name: 'Kitchen Appliances', parent: 'IC003'),
    ],
    name: 'Caesar salad croquettes - 500gm',
    images: [
      'https://storage.googleapis.com/vyser-product-database/kurkure-masala-munch-crisps/20240517_132915.png'
    ],
    brand_name: 'HomeBrand',
    is_selling_price_exclusive_of_gst: false,
    item_tax_detail: {'GST': 12},
    unit_denomination: 'gm',
    unit_value: '50',
    product_reference_images: ['ref_mixer1.jpg'],
    is_item_group: false,
    symbol: '₹',
    description: 'Powerful mixer grinder with 3 jars',
    max_retail_price: 3000.0,
    selling_price: 2700.0,
    group_parent_item: null,
    item_specific_details: {'wattage': '750W', 'color': 'White'},
  ),
  const CatalogItem(
    id: 'C002',
    product_id: 'P002',
    product_full_path: '/home/kitchen',
    product_set_id: 'SET002',
    sub_categories: [
      ItemCategory(id: 'IC003', name: 'Home Appliances'),
      ItemCategory(id: 'IC004', name: 'Kitchen Appliances', parent: 'IC003'),
    ],
    name: 'Caesar salad croquettes',
    images: [
      'https://storage.googleapis.com/vyser-product-database/kurkure-masala-munch-crisps/20240517_132915.png'
    ],
    brand_name: 'HomeBrand',
    is_selling_price_exclusive_of_gst: false,
    item_tax_detail: {'GST': 12},
    unit_denomination: 'kg',
    unit_value: '1',
    product_reference_images: ['ref_mixer1.jpg'],
    is_item_group: false,
    symbol: '₹',
    description: 'Powerful mixer grinder with 3 jars',
    max_retail_price: 3000.0,
    selling_price: 2700.0,
    group_parent_item: null,
    item_specific_details: {'wattage': '750W', 'color': 'White'},
  ),
];

// Sample VisionProductSearchGroupedResult instances
List<VisionProductSearchGroupedResult> visionResults = [
  const VisionProductSearchGroupedResult(
    BoundingPoly([
      NormalizedVertex(x: 0.1, y: 0.2),
      NormalizedVertex(x: 0.4, y: 0.2),
      NormalizedVertex(x: 0.4, y: 0.6),
      NormalizedVertex(x: 0.1, y: 0.6),
    ]),
    [
      VisionSearchProductInfoWithScore(
        product: VisionSearchProductInfo(
          name: 'Smartphone',
          product_id: 'P001',
          display_name: 'TechBrand Smartphone',
          product_category: 'Electronics',
          product_labels: [
            {'feature': 'touchscreen'},
            {'feature': '128GB'}
          ],
        ),
        score: 0.95,
        image: 'detected_phone.jpg',
      ),
    ],
  ),
  const VisionProductSearchGroupedResult(
    BoundingPoly([
      NormalizedVertex(x: 0.5, y: 0.3),
      NormalizedVertex(x: 0.8, y: 0.3),
      NormalizedVertex(x: 0.8, y: 0.7),
      NormalizedVertex(x: 0.5, y: 0.7),
    ]),
    [
      VisionSearchProductInfoWithScore(
        product: VisionSearchProductInfo(
          name: 'Mixer Grinder',
          product_id: 'P002',
          display_name: 'HomeBrand Mixer Grinder',
          product_category: 'Home Appliances',
          product_labels: [
            {'feature': '750W'},
            {'feature': '3 jars'}
          ],
        ),
        score: 0.90,
        image: 'detected_mixer.jpg',
      ),
    ],
  ),
];

VisionSearchResponse visionSearchResponse =
    VisionSearchResponse(visionResults, {
  'P001': [catalogItems[0]],
  'P002': [catalogItems[1], catalogItems[2]]
});
