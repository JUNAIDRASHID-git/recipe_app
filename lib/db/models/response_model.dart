class RecipeModel {
  final String name;
  final String yield;
  final String prepTime;
  final String cookTime;
  final List<String> ingredients;
  final List<String> instructions;
  final List<String> tips;

  RecipeModel({
    required this.name,
    required this.yield,
    required this.prepTime,
    required this.cookTime,
    required this.ingredients,
    required this.instructions,
    required this.tips,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'yield': yield,
    'prepTime': prepTime,
    'cookTime': cookTime,
    'ingredients': ingredients,
    'instructions': instructions,
    'tips': tips,
  };
}