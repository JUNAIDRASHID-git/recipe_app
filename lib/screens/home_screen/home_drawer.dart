import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe_app/buttons/sidebarbutton.dart';
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
          const Padding(
            padding: EdgeInsets.only(right: 5, bottom: 20, top: 10),
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 30),
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
                text: "Saved Recipes",
                action: () {
                  log("Saved Recipes Clicked");
                },
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: SidebarButtons(
                text: "Settings",
                action: () {
                  log("Settings Cilcked");
                },
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: SidebarButtons(
                text: "About",
                action: () {
                  log("About Cilcked");
                },
              )),
        ],
      )),
    );
  }
}
