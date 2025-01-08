import 'dart:convert';

import 'package:dropy/constants/constants.dart';
import 'package:dropy/landing/landing.dart';
import 'package:dropy/utils/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';

abstract class HiveService {
  Future<void> initBoxes();

  void persistUserLocation({required DropyPositionModel dropyPositionModel});
  DropyPositionModel? retrieveUserLocation();
  void deleteUserLocation();
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
      key: DropyConfig.instance!.values.hiveBoxEncryptionKey,
    );
    if (encryptionKeyString == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: DropyConfig.instance!.values.hiveBoxEncryptionKey,
        value: base64UrlEncode(key),
      );
    }
    final key = await secureStorage.read(
      key: DropyConfig.instance!.values.hiveBoxEncryptionKey,
    );
    final encryptionKeyUint8List = base64Url.decode(key!);

    Hive.registerAdapter(UserLocationAdapter());

    await Hive.openBox<dynamic>(
      DropyConfig.instance!.values.hiveBoxKey,
      encryptionCipher: HiveAesCipher(encryptionKeyUint8List),
    );
  }

  @override
  void clearBox() {
    Hive.box<dynamic>(DropyConfig.instance!.values.hiveBoxKey).deleteAll([
      'user-location',
    ]);
  }

  @override
  void persistUserLocation({required DropyPositionModel dropyPositionModel}) {
    try {
      Hive.box<dynamic>(DropyConfig.instance!.values.hiveBoxKey)
          .put('user-location', dropyPositionModel);
    } catch (_) {}
  }

  @override
  DropyPositionModel? retrieveUserLocation() {
    try {
      final box = Hive.box<dynamic>(DropyConfig.instance!.values.hiveBoxKey);
      final position = box.get('user-location') as DropyPositionModel?;
      if (position == null) return null;
      return position;
    } catch (_) {}
    return null;
  }

  @override
  void deleteUserLocation() {
    try {
      Hive.box<dynamic>(DropyConfig.instance!.values.hiveBoxKey)
          .delete('user-location');
    } catch (_) {}
  }

  @override
  void persistToken(String token) {
    Hive.box<dynamic>(DropyConfig.instance!.values.hiveBoxKey)
        .put('accessToken', token);
  }

  @override
  String? retrieveToken() {
    final box = Hive.box<dynamic>(DropyConfig.instance!.values.hiveBoxKey);
    final accessToken = box.get('accessToken') as String?;
    if (accessToken == null) return null;
    return accessToken;
  }
}
