import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:habit_tracker/auth/auth.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/home/home.dart';
import 'package:habit_tracker/utils/utils.dart';
import 'package:hive_ce_flutter/adapters.dart';

abstract class HiveService {
  Future<void> initBoxes();
  void persistUserInfo({required LoginResponseDto loginDetails});
  LoginResponseDto? retrieveUserInfo();
  void persistCreatedHabits({required List<CreateHabitModel> createdHabits});
  List<CreateHabitModel>? retrieveCreatedHabits();
  void clearBox();
}

class HiveServiceImplementation implements HiveService {
  static const String userInfo = 'user-info';
  static const String habitsCreated = 'habits-created';

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

    Hive
      ..registerAdapter(
        LoginResponseAdapter(),
      )
      ..registerAdapter(
        CreateHabitAdapter(),
      );

    await Hive.openBox<dynamic>(
      HabitTrackerConfig.instance!.values.hiveBoxKey,
      encryptionCipher: HiveAesCipher(encryptionKeyUint8List),
    );
  }

  @override
  void clearBox() {
    Hive.box<dynamic>(HabitTrackerConfig.instance!.values.hiveBoxKey)
        .deleteAll([
      userInfo,
    ]);
  }

  @override
  void persistUserInfo({required LoginResponseDto loginDetails}) {
    Hive.box<dynamic>(HabitTrackerConfig.instance!.values.hiveBoxKey)
        .put(userInfo, loginDetails);
  }

  @override
  LoginResponseDto? retrieveUserInfo() {
    final box =
        Hive.box<dynamic>(HabitTrackerConfig.instance!.values.hiveBoxKey);
    final userDetails = box.get(userInfo) as LoginResponseDto?;
    if (userDetails == null) return null;
    return userDetails;
  }

  @override
  void persistCreatedHabits({required List<CreateHabitModel> createdHabits}) {
    try {
      Hive.box<dynamic>(HabitTrackerConfig.instance!.values.hiveBoxKey)
          .put(habitsCreated, createdHabits);
    } catch (_) {}
  }

  @override
  List<CreateHabitModel>? retrieveCreatedHabits() {
    try {
      final box =
          Hive.box<dynamic>(HabitTrackerConfig.instance!.values.hiveBoxKey);
      final habits = box.get(habitsCreated) as List<CreateHabitModel>?;
      if (habits == null) return null;
      return habits;
    } catch (_) {}
    return null;
  }
}
