import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:recipe_app/colors/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: fontColor),
        backgroundColor: mainbgcolor,
        title: Center(
            child: Text(
          "Settings       ",
          style: TextStyle(color: fontColor, fontSize: 30),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 120, top: 20),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Column(
                          children: [
                            Expanded(
                              child: FutureBuilder(
                                future:
                                    Future.delayed(const Duration(milliseconds: 150))
                                        .then((value) {
                                  return rootBundle.loadString(
                                      'assets/Terms_and_Conditins/Terms_and_Conditions.md');
                                }),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Markdown(data: snapshot.data!);
                                  }
                                  return const Center(child: Text("Loading...."));
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                               TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child:const Text("Close"))
                            ],)
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Text("Terms & Conditions")),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Column(
                          children: [
                            Expanded(
                              child: FutureBuilder(
                                future:
                                    Future.delayed(const Duration(milliseconds: 150))
                                        .then((value) {
                                  return rootBundle.loadString(
                                      'assets/Privacy_Policy/privacy_policy.md');
                                }),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Markdown(data: snapshot.data!);
                                  }
                                  return const Center(child: Text("Loading...."));
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child:const Text("Close"))
                            ],)
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Text("Privacy & Policy"))
          ],
        ),
      ),
    );
  }
}
