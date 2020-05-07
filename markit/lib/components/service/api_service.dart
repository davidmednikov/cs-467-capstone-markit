
import 'dart:convert';
import 'package:http/http.dart';

import 'package:markit/components/service/auth_service.dart';

class ApiService {

  AuthService authService = new AuthService();

  Future<List> getList(String url) async {
    Response response = await makeGetCall(url, true);
    Map<String, Object> body = jsonDecode(response.body);
    if (body['statusCode'] == 200) {
      return List.from(body['data']);
    }
    return Future.value([]);
  }

  Future<Map> getMap(String url) async {
    Response response = await makeGetCall(url, true);
    Map<String, Object> body = jsonDecode(response.body);
    if (body['statusCode'] == 200) {
      return body['data'];
    }
    return Future.value({});
  }

  Future<Response> makeGetCall(String url, bool retry) async {
    String token = await authService.getToken();
    Response response = await get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if (retry && response.statusCode == 401) {
      bool newToken = await authService.updateToken();
      if (newToken) {
        return makeGetCall(url, false);
      }
    }
    return Future.value(response);
  }

  Future<List> postResponseList(String url, Map<String, Object> body) async {
    Response response = await makePostCall(url, body, true);
    Map<String, Object> responseBody = jsonDecode(response.body);
    if (responseBody['statusCode'] == 200) {
      return List.from(responseBody['data']);
    }
    return Future.value([]);
  }

  Future<Map> postResponseMap(String url, Map<String, Object> body) async {
    Response response = await makePostCall(url, body, true);
    Map<String, Object> responseBody = jsonDecode(response.body);
    if (responseBody['statusCode'] == 200) {
      return responseBody['data'];
    }
    return Future.value({});
  }

   Future<Response> makePostCall(String url, Map<String, Object> body, bool retry) async {
    String token = await authService.getToken();
    Response response = await post(url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (retry && response.statusCode == 401) {
      bool newToken = await authService.updateToken();
      if (newToken) {
        return makePostCall(url, body, false);
      }
    }
    return Future.value(response);
  }

  Future<List> patchResponseList(String url, Map<String, Object> body) async {
    Response response = await makePatchCall(url, body, true);
    Map<String, Object> responseBody = jsonDecode(response.body);
    if (responseBody['statusCode'] == 200) {
      return List.from(responseBody['data']);
    }
    return Future.value([]);
  }

  Future<Map> patchResponseMap(String url, Map<String, Object> body) async {
    Response response = await makePatchCall(url, body, true);
    Map<String, Object> responseBody = jsonDecode(response.body);
    if (responseBody['statusCode'] == 200) {
      return responseBody['data'];
    }
    return Future.value({});
  }

   Future<Response> makePatchCall(String url, Map<String, Object> body, bool retry) async {
    String token = await authService.getToken();
    Response response = await patch(url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (retry && response.statusCode == 401) {
      bool newToken = await authService.updateToken();
      if (newToken) {
        return makePatchCall(url, body, false);
      }
    }
    return Future.value(response);
  }

  Future<List> putResponseList(String url, Map<String, Object> body) async {
    Response response = await makePutCall(url, body, true);
    Map<String, Object> responseBody = jsonDecode(response.body);
    if (responseBody['statusCode'] == 200) {
      return List.from(responseBody['data']);
    }
    return Future.value([]);
  }

  Future<Map> putResponseMap(String url, Map<String, Object> body) async {
    Response response = await makePutCall(url, body, true);
    Map<String, Object> responseBody = jsonDecode(response.body);
    if (responseBody['statusCode'] == 200) {
      return responseBody['data'];
    }
    return Future.value({});
  }

  Future<Response> makePutCall(String url, Map<String, Object> body, bool retry) async {
    String token = await authService.getToken();
    Response response = await put(url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (retry && response.statusCode == 401) {
      bool newToken = await authService.updateToken();
      if (newToken) {
        return makePutCall(url, body, false);
      }
    }
    return Future.value(response);
  }

  Future<int> deleteResponseCode(String url) async {
    Response response = await makeDeleteCall(url, true);
    return Future.value(response.statusCode);
  }

  Future<Response> makeDeleteCall(String url, bool retry) async {
    String token = await authService.getToken();
    Response response = await delete(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if (retry && response.statusCode == 401) {
      bool newToken = await authService.updateToken();
      if (newToken) {
        return makeDeleteCall(url, false);
      }
    }
    return Future.value(response);
  }

  Future<int> getUserId() async {
    String url = 'https://markit-api.azurewebsites.net/user/currentUser';
    Map response = await getMap(url);
    return Future.value(response['id']);
  }
}