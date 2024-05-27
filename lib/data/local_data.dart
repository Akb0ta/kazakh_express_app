import 'package:bus_app/api/api.dart';

class LocalData {
  // Private constructor
  LocalData._privateConstructor();

  // Singleton instance
  static final LocalData _instance = LocalData._privateConstructor();

  // Getter for the singleton instance
  static LocalData get instance => _instance;
  Map<String, dynamic>? locations = {};
  // Your local data management methods can go here
  Future<void> initDatas() async {
    locations = await ApiClient().get('cities', 'tmOzkhGQwTpVtCauIIlI');
  }
}
