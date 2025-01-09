import 'dart:convert';

import 'package:habit_tracker/auth/auth.dart';
import 'package:habit_tracker/home/home.dart';
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

class CreateHabitAdapter extends TypeAdapter<CreateHabitModel> {
  @override
  final typeId = 2;

  @override
  CreateHabitModel read(BinaryReader reader) {
    return CreateHabitModel.fromJson(
      Map<String, dynamic>.of(
        json.decode(reader.read() as String) as Map<String, dynamic>,
      ),
    );
  }

  @override
  void write(BinaryWriter writer, CreateHabitModel obj) {
    writer.write(json.encode(obj.toJson()));
  }
}

class CreateHabitsAdapter extends TypeAdapter<CreatedHabitsModel> {
  @override
  final typeId = 3;

  @override
  CreatedHabitsModel read(BinaryReader reader) {
    return CreatedHabitsModel.fromJson(
      Map<String, dynamic>.of(
        json.decode(reader.read() as String) as Map<String, dynamic>,
      ),
    );
  }

  @override
  void write(BinaryWriter writer, CreatedHabitsModel obj) {
    writer.write(json.encode(obj.toJson()));
  }
}

class CompletedHabitsAdapter extends TypeAdapter<CompletedHabitsModel> {
  @override
  final typeId = 4;

  @override
  CompletedHabitsModel read(BinaryReader reader) {
    return CompletedHabitsModel.fromJson(
      Map<String, dynamic>.of(
        json.decode(reader.read() as String) as Map<String, dynamic>,
      ),
    );
  }

  @override
  void write(BinaryWriter writer, CompletedHabitsModel obj) {
    writer.write(json.encode(obj.toJson()));
  }
}
