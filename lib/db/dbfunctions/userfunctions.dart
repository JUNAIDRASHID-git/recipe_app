import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/db/models/userdb.dart';


 

void addUser({required String email,required String username,required String password,required String id}) async {
  final userDB = await Hive.openBox<User>("user_db");
  final newUser =  User(email: email, username: username, password: password,id: DateTime.now().millisecondsSinceEpoch.toString());
  userDB.put(id,newUser);
 
}



