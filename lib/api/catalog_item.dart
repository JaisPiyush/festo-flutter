import 'package:festo_app/api/client.dart';
import 'package:festo_app/models/vision_search/vision_search_response.dart';

class CatalogItemAPIClient {
  final ApiClient client;
  const CatalogItemAPIClient(this.client);

  Future<VisionSearchResponse> visionSearch(String url) async {
    final res = await client.client.get<Map<String, dynamic>>(
        '/catalog/search/',
        queryParameters: {'image_uri': Uri.encodeComponent(url)});
    return VisionSearchResponse.fromJson(res.data!);
  }
}
