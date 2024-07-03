import 'package:flutter/material.dart';
import 'package:recipe_app/db/models/recipedb.dart';

class DialogMessageWidget extends StatelessWidget {
  const DialogMessageWidget({super.key, required this.data, required this.yesAction, required this.messageText});
  final Recipe data;
  final void Function() yesAction;
  final String messageText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        height: 100,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(messageText),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: yesAction,
                    child: const Text("YES")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("NO")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
