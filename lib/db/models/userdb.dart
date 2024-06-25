import 'package:hive/hive.dart';
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
  

  User({required this.email, required this.username, required this.password,required this.id});
}
