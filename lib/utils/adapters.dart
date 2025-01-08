import 'dart:convert';

import 'package:habit_tracker/auth/auth.dart';
import 'package:hive_ce/hive.dart';

class LoginResponseAdapter extends TypeAdapter<LoginResponseDto> {
  @override
  final typeId = 1;

  @override
  LoginResponseDto read(BinaryReader reader) {
    return LoginResponseDto.fromJson(
      Map<String, dynamic>.of(
        json.decode(reader.read() as String) as Map<String, dynamic>,
      ),
    );
  }

  @override
  void write(BinaryWriter writer, LoginResponseDto obj) {
    writer.write(json.encode(obj.toJson()));
  }
}
