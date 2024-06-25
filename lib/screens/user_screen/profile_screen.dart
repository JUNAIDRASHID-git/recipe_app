import 'package:flutter/material.dart';
import 'package:recipe_app/buttons/sidebarbutton.dart';
import 'package:recipe_app/db/models/userdb.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userdetails});

  final User userdetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(180, 75, 75, 75),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        backgroundColor: Colors.transparent,
        title: const Center(
            child: Padding(
          padding: EdgeInsets.only(right: 50),
          child: Text(
            "My Profile",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        )),
        toolbarHeight: 75,
      ),
      body: Column(
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
                  const SizedBox(
                    width: 20,
                  ),
                  const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    child: Image(
                      image: AssetImage("assets/logos/userdefault.jpg"),
                      height: 100,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userdetails.username.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 30, color: Colors.white),
                        ),
                        Text(
                          userdetails.email,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SidebarButtons(
                  text: 'My Orders',
                  action: () {},
                ),
                const SizedBox(
                  height: 15,
                ),
                SidebarButtons(
                  text: 'Shipping Address',
                  action: () {},
                ),
                const SizedBox(
                  height: 15,
                ),
                SidebarButtons(
                  text: 'Payment Methords',
                  action: () {},
                ),
                const SizedBox(
                  height: 15,
                ),
                SidebarButtons(
                  text: 'Saved Recipes',
                  action: () {},
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
