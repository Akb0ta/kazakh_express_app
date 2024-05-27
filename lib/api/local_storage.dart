import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Create operation
  Future<void> create(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Read operation
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  // Update operation
  Future<void> update(String key, String newValue) async {
    await _storage.write(key: key, value: newValue);
  }

  // Delete operation
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // Clear all data operation
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
