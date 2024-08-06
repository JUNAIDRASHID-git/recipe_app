import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/db/functions/ai_functions.dart';
import 'package:recipe_app/widgets/progress_widgets/circle_progress.dart';

bool loadingWidget = false;

Padding aiGenerateButton(
  setState,
  List<String> ingredientsList,
  String responseTxt,
  aiRecipe,
) {
  return Padding(
    padding: EdgeInsets.only(
        left: loadingWidget ? 40 : 50,
        right: loadingWidget ? 40 : 50,
        bottom: 80),
    child: ElevatedButton(
      style: const ButtonStyle(
        fixedSize: WidgetStatePropertyAll(Size.fromHeight(60)),
        backgroundColor: WidgetStatePropertyAll(Colors.deepPurple),
      ),
      onPressed: () async {
        setState(() {
          loadingWidget = true;
        });
        try {
          final ingredients = ingredientsList.join(',');
          final response = await sendRequest(ingredients);

          final jsonResponse = jsonDecode(response);

          if (jsonResponse['candidates'] != null &&
              jsonResponse['candidates'].isNotEmpty) {
            final content =
                jsonResponse['candidates'][0]['content']['parts'][0]['text'];

            setState(() {
              responseTxt = content;
            });

            final recipe = parseRecipe(content);

            aiRecipe.value = recipe;
          } else if (jsonResponse['error'] != null) {
            log("API error");
          }
        } finally {
          setState(() {
            loadingWidget = false;
          });
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Generate Recipe  ",
            style: TextStyle(fontSize: 30, color: fontColor),
          ),
          loadingWidget ? const AILoadingWidget() : const SizedBox.shrink()
        ],
      ),
    ),
  );
}
