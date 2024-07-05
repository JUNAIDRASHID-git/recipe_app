import 'package:flutter/material.dart';

class DialogMessageWidget extends StatefulWidget {
  const DialogMessageWidget(
      {super.key, required this.yesAction, required this.messageText});

  final void Function()? yesAction;
  final String messageText;

  @override
  State<DialogMessageWidget> createState() => _DialogMessageWidgetState();
}

class _DialogMessageWidgetState extends State<DialogMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.messageText),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: widget.yesAction,
                  child: const Text("YES"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("NO"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
