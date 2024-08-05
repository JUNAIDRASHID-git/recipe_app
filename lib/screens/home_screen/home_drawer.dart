import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/screens/home_screen/settings_screen.dart';
import 'package:recipe_app/widgets/about.dart';
import 'package:recipe_app/widgets/buttons/sidebarbutton.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/screens/user_screen/profile_screen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key, required this.userdetails});
  final User userdetails;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 98, 98, 98),
      child: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5, bottom: 20, top: 10),
            child: Text(
              "Menu",
              style: TextStyle(
                  color: fontColor, fontSize: 30, fontFamily: "Roboto"),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              height: 20,
              thickness: 5,
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: SidebarButtons(
                text: "Profile",
                action: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                            userdetails: userdetails,
                          )));
                  log("Profile Cilcked");
                },
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: SidebarButtons(
                text: "Settings",
                action: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ));
                },
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: SidebarButtons(
                text: "About",
                action: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return  Dialog(
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                child: SingleChildScrollView(
                                  child: Text(about,style:const TextStyle(fontSize: 15),),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(onPressed: (){
                                    Navigator.pop(context);
                                }, child: const Text("Close"))
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              )),
        ],
      )),
    );
  }
}
