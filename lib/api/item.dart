import 'package:festo_app/api/client.dart';
import 'package:festo_app/models/vision_search/vision_inventory_item_search_response.dart';

class ItemAPIClient {
  final ApiClient client;
  ItemAPIClient(this.client);

  Future<VisionInventoryItemSearchResponse> visionSearchInventory(
      String url) async {
    final res = await client.client
        .get('/item/search/', queryParameters: {'image_uri': url});
    return VisionInventoryItemSearchResponse.fromJson(res.data);
  }
}
