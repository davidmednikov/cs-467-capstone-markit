import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:markit/components/service/auth_service.dart';

class TutorialService {

  // Create storage
  final storage = new FlutterSecureStorage();

  AuthService authService = new AuthService();

  Future<bool> shouldShowHomeTutorial() async {
    int userId = await authService.getUserIdFromStorage();
    String showTutorial = await storage.read(key: '${userId}_homeTutorial');
    if (showTutorial != null && showTutorial == 'true') {
      return true;
    }
    return false;
  }

  Future<bool> shouldShowViewListTutorial() async {
    int userId = await authService.getUserIdFromStorage();
    String showTutorial = await storage.read(key: '${userId}_viewListTutorial');
    if (showTutorial != null && showTutorial == 'true') {
      return true;
    }
    return false;
  }

  void storeAllTutorialsUnwatched(int userId) {
    homeTutorialUnwatched(userId);
    viewListTutorialUnwatched(userId);
  }

  void homeTutorialUnwatched(userId) async {
    storage.write(key: '${userId}_homeTutorial', value: true.toString());
  }

  void viewListTutorialUnwatched(userId) async {
    storage.write(key: '${userId}_viewListTutorial', value: true.toString());
  }

  void homeTutorialWatched() async {
    int userId = await authService.getUserIdFromStorage();
    storage.delete(key: '${userId}_homeTutorial');
  }

  void viewListTutorialWatched() async {
    int userId = await authService.getUserIdFromStorage();
    storage.delete(key: '${userId}_viewListTutorial');
  }
}