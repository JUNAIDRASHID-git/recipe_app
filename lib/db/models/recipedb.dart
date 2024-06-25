import 'package:hive/hive.dart';
part 'recipedb.g.dart';

@HiveType(typeId: 1)
class Recipe {
  @HiveField(0)
  String image;
  @HiveField(1)
  String title;
  @HiveField(2)
  int time;
  @HiveField(3)
  String description;
  @HiveField(4)
  String ingrediants;
  @HiveField(5)
  String instruction;
@HiveField(6)
  bool veg;
  @HiveField(7)
  bool fav;
  @HiveField(8)
  int id;

  Recipe(
      {required this.image,
      required this.title,
      required this.time,
      required this.description,
      required this.ingrediants,
      required this.instruction,
      required this.id,
      required this.veg,
      required this.fav
      });
}
