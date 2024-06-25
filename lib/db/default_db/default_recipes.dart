import 'package:recipe_app/db/models/recipedb.dart';

List<Recipe> defaultRecipes = [
// recipe 1
  Recipe(
      image: "assets/recipe_pngs/kebab.png",
      title: "Kebab",
      time: 25,
      description:
          "Kebab features marinated, skewered, and grilled meat, often lamb, chicken, or beef, with vegetables, cooked over an open flame for a smoky, savory, tender taste.",
      ingrediants: """
Chicken breast or thighs (boneless, skinless, 500 grams)
Yogurt (1/2 cup)
Garlic (3-4 cloves, minced)
Ginger (1-inch piece, grated)
Lemon juice (2 tablespoons)
Olive oil (2 tablespoons)
Ground cumin (1 teaspoon)
Ground coriander (1 teaspoon)
Paprika (1 teaspoon)
Turmeric (1/2 teaspoon)
Garam masala (1 teaspoon)
Salt (to taste)
Ground black pepper (1 teaspoon)
Chili powder (optional, for heat, 1/2 teaspoon)
Fresh cilantro (chopped, for garnish)
Vegetables for skewering (optional, such as bell peppers, onions, cherry tomatoes)""",
      instruction: """Prepare the Chicken:
Cut the boneless, skinless chicken breast or thighs (500 grams) into bite-sized pieces.

Make the Marinade:

In a large bowl, mix together 1/2 cup of yogurt, 3-4 minced garlic cloves, 1-inch grated ginger, 2 tablespoons of lemon juice, and 2 tablespoons of olive oil.
Add the spices: 1 teaspoon ground cumin, 1 teaspoon ground coriander, 1 teaspoon paprika, 1/2 teaspoon turmeric, 1 teaspoon garam masala, salt to taste, 1 teaspoon ground black pepper, and 1/2 teaspoon chili powder (if using).
Mix the marinade ingredients well to combine.
Marinate the Chicken:

Add the chicken pieces to the marinade, ensuring each piece is well-coated.
Cover the bowl and refrigerate for at least 1 hour, preferably 4-6 hours or overnight for best results.
Prepare the Skewers:

If using wooden skewers, soak them in water for at least 30 minutes to prevent burning.
Thread the marinated chicken pieces onto the skewers. You can also add vegetables like bell peppers, onions, and cherry tomatoes between the chicken pieces.
Preheat the Grill:

Preheat your grill to medium-high heat (around 375-450°F or 190-230°C).
You can also use a grill pan or broiler if you don't have an outdoor grill.
Grill the Kebabs:

Place the skewers on the grill.
Cook for about 5-7 minutes on each side, turning occasionally, until the chicken is cooked through and has a nice char. The internal temperature should reach 165°F (74°C).
Rest and Serve:

Once cooked, remove the skewers from the grill and let them rest for a few minutes.
Garnish with chopped fresh cilantro and optionally chopped mint leaves.
Serve hot with naan, pita bread, rice, or a fresh salad, along with a side of yogurt sauce or chutney.""",
      id: 1,
      veg: false, fav: true),
// recipe 2
  
  Recipe(
      image: "assets/recipe_pngs/Samosa.png",
      title: "Samosa",
      time: 10,
      description:
          "Veg samosa is a crispy, triangular Indian snack with spiced vegetable filling, served with chutneys, and enjoyed as a tea-time treat.",
      ingrediants: "chilli powder",
      instruction: "coock 10min",
      id: 2,
      veg: true, fav: false),

// recipe 3

  Recipe(
      image: "assets/recipe_pngs/pizza (3).png",
      title: "PIZZA",
      time: 45,
      description:
          "Italian pizza features a thin, crispy crust, rich tomato sauce, fresh mozzarella, and high-quality toppings like basil and cured meats, embodying authentic Italian flavors.",
      ingrediants: """For the Dough:
All-purpose flour (2 1/2 cups)
Warm water (1 cup)
Active dry yeast (2 1/4 teaspoons or 1 packet)
Olive oil (2 tablespoons)
Salt (1 teaspoon)
Sugar (1 teaspoon)
For the Sauce:
Canned tomatoes (preferably San Marzano, 1 can, 14-16 ounces)
Garlic (2-3 cloves, minced)
Olive oil (2 tablespoons)
Salt (to taste)
Fresh basil leaves (a handful, chopped)
Oregano (1 teaspoon)
For the Toppings:
Fresh mozzarella cheese (8 ounces, sliced or torn)
Fresh basil leaves (for garnish)
Parmesan cheese (grated, optional)
Olive oil (for drizzling)
Optional Toppings:
Prosciutto
Olives
Artichoke hearts
Mushrooms
Bell peppers
Arugula
Cherry tomatoes""",
      instruction: """Prepare the Dough:
Activate the Yeast:

In a small bowl, combine 1 cup of warm water, 2 1/4 teaspoons of active dry yeast, and 1 teaspoon of sugar.
Let it sit for about 5-10 minutes until it becomes frothy.
Mix the Dough:

In a large bowl, combine 2 1/2 cups of all-purpose flour and 1 teaspoon of salt.
Make a well in the center and add the yeast mixture and 2 tablespoons of olive oil.
Mix until a dough forms.
Knead the Dough:

Transfer the dough to a floured surface and knead for about 8-10 minutes until smooth and elastic.
Place the dough in a lightly oiled bowl, cover with a damp cloth, and let it rise in a warm place for about 1-2 hours, or until it doubles in size.
2. Prepare the Sauce:
Make the Tomato Sauce:
In a blender, puree 1 can of canned tomatoes (preferably San Marzano).
In a saucepan, heat 2 tablespoons of olive oil over medium heat.
Add 2-3 minced garlic cloves and sauté until fragrant (about 1 minute).
Add the pureed tomatoes, salt to taste, 1 teaspoon of oregano, and a handful of chopped fresh basil leaves.
Simmer for about 15-20 minutes until the sauce thickens slightly.
3. Assemble the Pizza:
Preheat the Oven:

Preheat your oven to its highest setting (usually around 475-500°F or 245-260°C). If you have a pizza stone, place it in the oven to preheat as well.
Shape the Dough:

Punch down the risen dough and transfer it to a floured surface.
Roll out or stretch the dough into a thin, round shape (about 12 inches in diameter).
Add the Toppings:

Transfer the shaped dough to a piece of parchment paper or a pizza peel if using a pizza stone.
Spread a thin layer of the prepared tomato sauce over the dough.
Add slices or torn pieces of fresh mozzarella cheese (about 8 ounces).
Add any optional toppings like prosciutto, olives, or mushrooms.
Bake the Pizza:

Carefully slide the pizza onto the preheated pizza stone or place the parchment paper with the pizza onto a baking sheet.
Bake for about 8-12 minutes, or until the crust is golden and crispy and the cheese is melted and bubbly.
4. Finish and Serve:
Garnish:

Remove the pizza from the oven and garnish with fresh basil leaves.
Drizzle a little olive oil over the top and add grated Parmesan cheese if desired.
Serve:

Slice the pizza and serve hot. Enjoy your delicious homemade Italian pizza!""",
      id: 3,
      veg: false, fav: false),

// recipe 4

  Recipe(
      image: "assets/recipe_pngs/grillchicken (2).png",
      title: "Grill Chicken",
      time: 20,
      description:
          "Grilled chicken, marinated with herbs, spices, and citrus, cooks over open flames, offering a smoky, caramelized exterior and juicy, flavorful meat.",
      ingrediants: """Chicken pieces (breasts, thighs, drumsticks, or wings)
Olive oil (2-3 tablespoons)
Garlic (3-4 cloves, minced)
Lemon juice (2-3 tablespoons)
Soy sauce (2 tablespoons)
Honey (1 tablespoon)
Paprika (1 teaspoon)
Ground black pepper (1 teaspoon)
Salt (to taste)
Dried herbs (such as thyme, rosemary, or oregano, 1 teaspoon each)
Optional:
Red pepper flakes (for a spicy kick, 1/2 teaspoon)
Mustard (1 tablespoon)
Yogurt (for a creamy marinade, 1/2 cup)""",
      instruction: """
Marinate the Chicken:
Place the chicken pieces in a large resealable plastic bag or a shallow dish.
Pour the marinade over the chicken, ensuring all pieces are well-coated.
Seal the bag or cover the dish and refrigerate for at least 1 hour, preferably 4-6 hours or overnight for maximum flavor.

Preheat the Grill:
Preheat your grill to medium-high heat (around 375-450°F or 190-230°C).

Grill the Chicken:
Remove the chicken from the marinade, letting any excess drip off.
Place the chicken pieces on the grill.
Cook for 6-8 minutes per side, depending on the thickness of the chicken, until the internal temperature reaches 165°F (74°C) and the juices run clear.
For bone-in pieces, it may take longer; boneless pieces will cook faster.

Rest and Serve:
Once cooked, transfer the chicken to a plate and let it rest for 5-10 minutes to retain its juices.
Serve hot with your favorite sides like grilled vegetables, rice, or salad.""",
      id: 4,
      veg: false, fav: true),

       Recipe(
      image: "assets/recipe_pngs/FrenchFries.png",
      title: "French Fries",
      time: 22,
      description:
          "French fries are crispy, deep-fried potato sticks, typically salted, and often served as a side dish or snack with condiments.",
      ingrediants: "chilli powder",
      instruction: "coock 10min",
      id: 5,
      veg: true, fav: false),
];

  

//     assets/logos/Into_Logo.png
//     assets/recipe_pngs/grillchicken (2).png
//     assets/recipe_pngs/kebab.png
//     assets/recipe_pngs/FrenchFries.png
//     assets/recipe_pngs/pizza (3).png
//     assets/recipe_pngs/Samosa.png


    