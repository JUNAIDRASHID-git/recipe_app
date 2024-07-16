import 'package:hive/hive.dart';
import 'package:recipe_app/db/models/recipedb.dart';
part 'userdb.g.dart';

@HiveType(typeId: 0)
class User {

  @HiveField(0)
  String email;
  @HiveField(1)
  String username;
  @HiveField(2)
  String password;
  @HiveField(3)
  String id;
  @HiveField(4)
  List<Recipe>?userRecipe;
  @HiveField(5)
  List<Recipe>?favorite;

  

  User({required this.email, required this.username, required this.password,required this.id,this.userRecipe,this.favorite});
}
