import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/db/functions/ai_functions.dart';
import 'package:recipe_app/db/models/response_model.dart';
import 'package:recipe_app/widgets/buttons/mainbutton.dart';
import 'package:recipe_app/widgets/containers/ai_recipe_details_list.dart';

class AIScreen extends StatefulWidget {
  const AIScreen({super.key});

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  List<String> ingredientsList = [];
  List<TextEditingController> ingredientsController = [TextEditingController()];
  ValueNotifier<RecipeModel> aiRecipe = ValueNotifier<RecipeModel>(RecipeModel(
    name: '',
    yield: '',
    prepTime: '',
    cookTime: '',
    ingredients: [],
    instructions: [],
    tips: [],
  ));
  String responseTxt = '';
  double height = 69;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              const AssetImage("assets/logos/ai.png"),
              color: fontColor,
            ),
          ],
        ),
        title: Text(
          "AI CHEF",
          style: TextStyle(color: fontColor),
        ),
        backgroundColor: mainbgcolor,
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: SizedBox(
                height: height,
                child: ListView.separated(
                  itemCount: ingredientsController.length,
                  itemBuilder: (context, index) {
                    return TextFormField(
                      controller: ingredientsController[index],
                      style: TextStyle(color: fontColor, fontSize: 20),
                      decoration: InputDecoration(
                        fillColor: textFormFieldColor,
                        filled: true,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (ingredientsController.length > 1) {
                                ingredientsController[index].clear();
                                ingredientsList.remove(ingredientsController[index].text);
                                ingredientsController.removeAt(index);
                                height = height - 80;
                              } else {
                                ingredientsController[index].clear();
                                ingredientsList.clear();
                              }
                            });
                          },
                          child: const Icon(Icons.delete),
                        ),
                        labelText: "Ingredient",
                        labelStyle: TextStyle(
                            color: fontColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: IconButton(
                            onPressed: () {
                              ingredientsController.add(TextEditingController());
                              if (ingredientsController[index].text.isNotEmpty) {
                                ingredientsList.add(ingredientsController[index].text);
                              }
                              log('${ingredientsController.length}');
                              log('${ingredientsList.length}');
                              setState(() {
                                height = height + 80;
                              });
                            },
                            icon: CircleAvatar(
                              backgroundColor: floatActionButtonColor,
                              child: Icon(
                                Icons.add,
                                size: 30,
                                color: fontColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                ),
              ),
            ),
        
            aiRecipeDetails(aiRecipe,context),
        
        
            Padding(
              padding: const EdgeInsets.only(bottom: 55),
              child: MainButton(
                buttonTitle: "Generate Recipe",
                buttonAction: () async {
                  try {
                    final ingredients = ingredientsList.join(',');
                    log('Sending request for ingredients: $ingredients');
        
                    final response = await sendRequest(ingredients);
        
                    log(response);
        
                    final jsonResponse = jsonDecode(response);
                    log('Decoded JSON response:');
                    log(jsonEncode(jsonResponse));
        
                    if (jsonResponse['candidates'] != null && jsonResponse['candidates'].isNotEmpty) {
                      final content = jsonResponse['candidates'][0]['content']['parts'][0]['text'];
                      log('Content to be parsed:');
                      log(content);
        
                      setState(() {
                        responseTxt = content;
                      });
        
                      final recipe = parseRecipe(content);
        
                      aiRecipe.value = recipe;
                    } else if (jsonResponse['error'] != null) {
                      log('API Error:');
                      log('Code: ${jsonResponse['error']['code']}');
                      log('Message: ${jsonResponse['error']['message']}');
                    } else {
                      log('Unexpected response structure. Raw response:');
                      log(jsonResponse.toString());
                    }
                  } catch (e) {
                    log('An error occurred:');
                    log(e.toString());
                    if (e is FormatException) {
                      log('JSON parsing error. Raw response might not be valid JSON.');
                    }
                  }
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  
}
