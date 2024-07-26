// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipedb.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 1;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      image: fields[0] as String,
      title: fields[1] as String,
      time: fields[2] as int,
      description: fields[3] as String,
      ingrediants: (fields[4] as List).cast<String>(),
      instruction: fields[5] as String,
      id: fields[8] as String,
      veg: fields[6] as bool,
      fav: fields[7] as bool,
      dishType: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.ingrediants)
      ..writeByte(5)
      ..write(obj.instruction)
      ..writeByte(6)
      ..write(obj.veg)
      ..writeByte(7)
      ..write(obj.fav)
      ..writeByte(8)
      ..write(obj.id)
      ..writeByte(9)
      ..write(obj.dishType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
