import 'package:flutter/material.dart';
import 'package:recipe_app/db/models/recipedb.dart';

class TimeWidgetContainer extends StatelessWidget {
  const TimeWidgetContainer({super.key, required this.data});
 final Recipe data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: data.time <= 20
            ? const Color.fromARGB(255, 122, 255, 126)
            : const Color.fromARGB(255, 255, 212, 19),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
      ),
      width: 70,
      child: Row(
        children: [
          const Icon(Icons.access_time_filled_sharp),
          Text("${data.time}min"),
        ],
      ),
    );
  }
}
