
import 'dart:convert';
import 'package:http/http.dart';

import 'auth_service.dart';

class ApiService {

  AuthService authService = new AuthService();

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

   Future<Response> makePostCall(String url, Map<String, Object> body, bool retry) async {
    String token = await authService.getToken();
    Response response = await post(url,
      headers: {
        'Authorization': 'Bearer $token',
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

   Future<Response> makePatchCall(String url, Map<String, Object> body, bool retry) async {
    String token = await authService.getToken();
    Response response = await patch(url,
      headers: {
        'Authorization': 'Bearer $token',
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

  Future<Response> makPutCall(String url, Map<String, Object> body, bool retry) async {
    String token = await authService.getToken();
    Response response = await put(url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
    if (retry && response.statusCode == 401) {
      bool newToken = await authService.updateToken();
      if (newToken) {
        return makPutCall(url, body, false);
      }
    }
    return Future.value(response);
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
}