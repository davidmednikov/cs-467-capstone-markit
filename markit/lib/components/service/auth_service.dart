import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {

  // Create storage
  final storage = new FlutterSecureStorage();

  Future<String> getToken() async {
    String storageToken = await getTokenFromStorage();
    if (storageToken != null) {
      return storageToken;
    }
    String username = await getUsernameFromStorage();
    String password = await getPasswordFromStorage();
    if (username != null && password != null) {
      String serverToken = await getTokenFromServer(username, password);
      if (serverToken != null) {
        storeToken(serverToken);
        return serverToken;
      }
    }
    return Future.value('NOT_AUTHENTICATED');
  }

  Future<String> getTokenFromStorage() async {
    return await storage.read(key: 'token');
  }

  Future<String> getUsernameFromStorage() async {
    return await storage.read(key: 'username');
  }

  Future<String> getPasswordFromStorage() async {
    return await storage.read(key: 'password');
  }

  Future<int> getUserIdFromStorage() async {
    return int.parse(await storage.read(key: 'userId'));
  }

  Future<String> getTokenFromServer(String userName, String password) async {
    String url = 'https://markit-api.azurewebsites.net/user/auth';
    Response response = await post(
      url,
      headers: {
        'Content-Type': 'application/json',
      }, body: jsonEncode({
        'userName': userName,
        'password': password,
      })
    );
    if (response.statusCode != 200) {
      return null;
    }
    String token = jsonDecode(response.body)['data']['token'];
    return Future.value(token);
  }

  void storeToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  void storeUserId(int userId) async {
    await storage.write(key: 'userId', value: userId.toString());
  }

  void storeUsername(String username) async {
    await storage.write(key: 'username', value: username);
  }

  void storePassword(String password) async {
    await storage.write(key: 'password', value: password);
  }

  void login(String username, String password, int userId) {
    storeUsername(username);
    storePassword(password);
    storeUserId(userId);
  }

  void logout() {
    storage.deleteAll();
  }

  Future<bool> updateToken() async {
    String username = await getUsernameFromStorage();
    String password = await getPasswordFromStorage();
    if (username != null && password != null) {
      String serverToken = await getTokenFromServer(username, password);
      if (serverToken != null) {
        storeToken(serverToken);
        return Future.value(true);
      }
    }
    return Future.value(false);
  }
}