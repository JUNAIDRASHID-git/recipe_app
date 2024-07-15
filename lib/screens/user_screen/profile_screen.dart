import 'package:flutter/material.dart';
import 'package:recipe_app/db/functions/db_functions/userfunctions.dart';
import 'package:recipe_app/screens/user_screen/saved_recipes_screeen.dart';
import 'package:recipe_app/widgets/bottombar/bottom_nav_bar.dart';
import 'package:recipe_app/widgets/buttons/mainbutton.dart';
import 'package:recipe_app/widgets/buttons/sidebarbutton.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/screens/user_screen/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.userdetails});

  final User userdetails;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SizedBox sizedBox = const SizedBox(width: 20);

  @override
  void initState() {
    super.initState();
    setState(() {
      getUser(id: widget.userdetails.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavBar(userdetails: widget.userdetails)),
                (route) => route.isFirst,
              );
            },
            icon: const Icon(Icons.arrow_back)),
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Text(
            "My Profile",
            style: TextStyle(color: fontColor, fontSize: 30),
          ),
        )),
        toolbarHeight: 75,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          child: Image(
                            image: AssetImage("assets/logos/userdefault.jpg"),
                            height: 100,
                          ),
                        ),
                      ),
                      sizedBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.userdetails.username.toUpperCase(),
                              style: TextStyle(fontSize: 30, color: fontColor),
                            ),
                            Text(
                              widget.userdetails.email,
                              style: TextStyle(fontSize: 15, color: fontColor),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    sizedBox,
                    SidebarButtons(
                      text: 'Saved Recipes',
                      action: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserSavedRecipes(
                                      userdetails: widget.userdetails,
                                    )));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          MainButton(
              buttonTitle: "LOGOUT",
              buttonAction: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false);
              }),
        ],
      ),
    );
  }
}
