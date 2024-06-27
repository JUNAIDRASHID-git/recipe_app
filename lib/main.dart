import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/screens/intro_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(UserAdapter().typeId)) {
    Hive.registerAdapter(UserAdapter());
  }
  if (!Hive.isAdapterRegistered(RecipeAdapter().typeId)) {
    Hive.registerAdapter(RecipeAdapter());
  }
  await Hive.openBox<User>("user_db");
  await Hive.openBox<Recipe>("recipe_db");

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(0, 75, 75, 75),
    systemNavigationBarColor: Color.fromARGB(203, 0, 0, 0),
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: IntroScreen(),
    );
  }
}
