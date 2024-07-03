import 'package:flutter/material.dart';
import 'package:recipe_app/db/models/recipedb.dart';

class VegWidgetContainer extends StatelessWidget {
  const VegWidgetContainer({super.key, required this.data});
  final Recipe data;

  @override
  Widget build(BuildContext context) {
    final vegcolor =
        data.veg != true ? Colors.red : const Color.fromARGB(255, 51, 118, 53);
    return Container(
      height: 25,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: vegcolor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              height: 15,
              width: 15,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: vegcolor,
                  ),
                ),
              ),
            ),
          ),
          Text(
            data.veg == true ? "Veg  " : "Non Veg  ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
