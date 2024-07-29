  import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/widgets/progress_widgets/circle_progress.dart';

Padding aiGenerateButton(void Function()? onPressed,loadingWidget) {
    return Padding(
            padding:  EdgeInsets.only(left: loadingWidget?40:50,right: loadingWidget?40:50,bottom: 80),
            child: ElevatedButton(
              style: const ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size.fromHeight(60)),
                backgroundColor: WidgetStatePropertyAll(Colors.deepPurple),
              ),
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Generate Recipe  ",
                    style: TextStyle(fontSize: 30, color: fontColor),
                  ),
                    loadingWidget? const AILoadingWidget() : const SizedBox.shrink()
                ],
              ),
            ),
          );
  }