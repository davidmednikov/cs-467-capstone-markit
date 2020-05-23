import 'package:markit/components/service/api_service.dart';

class TagService {

  ApiService apiService = new ApiService();

  Future<List> getTagsForUpc(String upc) async {
    String url = 'https://markit-api.azurewebsites.net/tags/query?upc=$upc';
    return await apiService.getList(url);
  }

  Future<List> getSuggestions(String pattern) async {
    String url = 'https://markit-api.azurewebsites.net/tags/query?name=$pattern';
    return List.from(await apiService.getList(url));
  }

  Future<Map> addTagToList(int listId, int tagId, String tagName, int quantity, String notes) {
    String url = 'https://markit-api.azurewebsites.net/list/$listId/listTag';
    var body = {
      'tag': {
        'id': tagId,
        'name': tagName,
      },
      'quantity': quantity,
      'comment': notes,
    };
    return apiService.postResponseMap(url, body);
  }

  Future<Map> updateTag(int listId, int listTagId, int tagId, String tagName, int quantity, String notes) async {
    String url = 'https://markit-api.azurewebsites.net/list/$listId/listTag/$listTagId';
    var body = {
      'id': listTagId,
      'tag': {
        'id': tagId,
        'name': tagName,
      },
      'quantity': quantity,
      'comment': notes,
    };
    return apiService.patchResponseMap(url, body);
  }
}