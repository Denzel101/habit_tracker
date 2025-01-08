import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:hive_ce_flutter/adapters.dart';

abstract class HiveService {
  Future<void> initBoxes();
  void persistToken(String token);
  String? retrieveToken();
  void clearBox();
}

class HiveServiceImplementation implements HiveService {
  @override
  Future<void> initBoxes() async {
    await Hive.initFlutter();

    const secureStorage = FlutterSecureStorage();
    final encryptionKeyString = await secureStorage.read(
      key: HabitTrackerConfig.instance!.values.hiveBoxEncryptionKey,
    );
    if (encryptionKeyString == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: HabitTrackerConfig.instance!.values.hiveBoxEncryptionKey,
        value: base64UrlEncode(key),
      );
    }
    final key = await secureStorage.read(
      key: HabitTrackerConfig.instance!.values.hiveBoxEncryptionKey,
    );
    final encryptionKeyUint8List = base64Url.decode(key!);

    // Hive.registerAdapter(UserLocationAdapter());

    await Hive.openBox<dynamic>(
      HabitTrackerConfig.instance!.values.hiveBoxKey,
      encryptionCipher: HiveAesCipher(encryptionKeyUint8List),
    );
  }

  @override
  void clearBox() {
    Hive.box<dynamic>(HabitTrackerConfig.instance!.values.hiveBoxKey)
        .deleteAll([
      'user-location',
    ]);
  }

  @override
  void persistToken(String token) {
    Hive.box<dynamic>(HabitTrackerConfig.instance!.values.hiveBoxKey)
        .put('accessToken', token);
  }

  @override
  String? retrieveToken() {
    final box =
        Hive.box<dynamic>(HabitTrackerConfig.instance!.values.hiveBoxKey);
    final accessToken = box.get('accessToken') as String?;
    if (accessToken == null) return null;
    return accessToken;
  }
}
