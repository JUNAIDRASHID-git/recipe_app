import 'package:flutter/material.dart';
import 'package:recipe_app/buttons/edit_delete_button.dart';
import 'package:recipe_app/db/dbfunctions/recipe_functions.dart';
import 'package:recipe_app/db/models/recipedb.dart';

class RecipeListAdmin extends StatefulWidget {
  const RecipeListAdmin({super.key});

  @override
  State<RecipeListAdmin> createState() => _RecipeListAdminState();
}

class _RecipeListAdminState extends State<RecipeListAdmin> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: recipeNotifier,
        builder:
            (BuildContext context, List<Recipe> recipeList, Widget? child) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final data = recipeList[index];
              final vegcolor = data.veg != true
                  ? Colors.red
                  : const Color.fromARGB(255, 51, 118, 53);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 98, 98, 98),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    width: 80,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            data.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 270,
                            child: data.image.isNotEmpty
                                ? Image.asset(data.image)
                                : const Text("No image"),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: data.veg == true
                                              ? const Color.fromARGB(
                                                  255, 122, 255, 126)
                                              : const Color.fromARGB(
                                                  255, 255, 212, 19),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(40))),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: vegcolor,
                                                        width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                height: 15,
                                                width: 15,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Center(
                                                    child: CircleAvatar(
                                                      backgroundColor: vegcolor,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          data.veg == true
                                              ? const Text(
                                                  "Veg  ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : const Text("Non Veg  ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: data.time <= 20
                                              ? const Color.fromARGB(
                                                  255, 122, 255, 126)
                                              : const Color.fromARGB(
                                                  255, 255, 212, 19),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(40))),
                                      width: 70,
                                      child: Row(
                                        children: [
                                          const Icon(
                                              Icons.access_time_filled_sharp),
                                          Text("${data.time}min"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  data.description,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              DeleteEditButton(
                                  buttonAction: () {},
                                  buttonTitle: "EDIT",
                                  color: const Color.fromARGB(255, 62, 62, 62),
                                  fontSize: 20),
                              DeleteEditButton(
                                  buttonAction: () {
                                   showDialog(context: context, builder: (context) {
                                     return  Dialog(
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
                                              Text("DO you want to DELETE\n${data.title} Recipe ?"),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  TextButton(onPressed: (){
                                                    deleteRecipe(data);
                                                    Navigator.pop(context);
                                                  }, child: const Text("YES")),
                                                  TextButton(onPressed: (){
                                                    Navigator.pop(context);
                                                  }, child: const Text("NO")),
                                                ],
                                              )
                                            ],
                                          ),
                                      ),
                                     );
                                   },);
                                  },
                                  buttonTitle: "DELETE",
                                  color: const Color.fromARGB(255, 180, 67, 59),
                                  fontSize: 20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemCount: recipeList.length,
          );
        },
      );
  }
}