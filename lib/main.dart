import 'package:flutter/material.dart';
import 'package:recipeapp/temp_recipe_list.dart';
import 'package:recipeapp/recipepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Rabia\'s Recipe Book'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: const TextStyle(
              fontSize: 15,
            )),
        centerTitle: true,
      ),

      drawer: const DrawerItem(),

      // https://www.javatpoint.com/flutter-gridview#builder
      body: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          // padding: const EdgeInsets.all(10),
          children: List.generate(recipes.length, (index) {
            return Center(
              child: RecipeCard(
                recipe: recipes[index], // passing in the recipe object
              ),
            );
          }, growable: true)),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Recipe App',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  )
                ]),
          ),
          ListTile(
            leading: const Icon(
              Icons.list_alt_outlined,
              size: 20,
            ),
            title: const Text('Recipes', style: TextStyle(fontSize: 12)),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const MyHomePage(title: 'Rabia\'s Recipe Book')),
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.red, size: 20),
            title:
                const Text('Favourite Recipes', style: TextStyle(fontSize: 12)),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FavouriteRecipesPage()),
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, size: 20),
            title: const Text('Settings', style: TextStyle(fontSize: 12)),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              )
            },
          ),
        ],
      ),
    );
  }
}

class FavouriteRecipesPage extends StatelessWidget {
  const FavouriteRecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rabia\'s Recipe Book',
            style: TextStyle(
              fontSize: 15,
            )),
        centerTitle: true,
      ),
      drawer: const DrawerItem(),
      body: const Center(
        child: Text('Favourite Recipes'),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rabia\'s Recipe Book',
            style: TextStyle(
              fontSize: 15,
            )),
        centerTitle: true,
      ),
      drawer: const DrawerItem(),
      body: const Center(
        child: Text('Settings'),
      ),
    );
  }
}

class Recipe {
  const Recipe(
      {required this.recipeName,
      required this.recipeAuthor,
      required this.amountOfIngredients,
      required this.recipeDifficulty,
      required this.cookingTime,
      required this.totalLikes,
      required this.imageUrl,
      required this.isFavourite,
      required this.description,
      required this.ingredients,
      required this.directions,
      required this.cookTime});

  final String recipeName;
  final String recipeAuthor;
  final String amountOfIngredients;
  final String recipeDifficulty;
  final String cookingTime;
  final int totalLikes;
  final String imageUrl;
  final bool isFavourite;
  final String description;
  final List<String> ingredients;
  final List<String> directions;
  final int cookTime;
  // icons
  final Icon recipeDifficultyIcon =
      const Icon(Icons.question_mark, size: 15, color: Colors.white);
  final Icon ingredientCostIcon =
      const Icon(Icons.attach_money, size: 15, color: Colors.white);
  final Icon cookingTimeIcon =
      const Icon(Icons.timer, size: 15, color: Colors.white);
}

List recipes = temp_recipe_list; // imported from temp_recipe_list.dart

@override // TODO: figure out if I even need this
class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    const TextStyle bodyTextStyle = TextStyle(
      fontSize: 8,
      color: Colors.white,
    );
    // final TextStyle? headerTextStyle = Theme.of(context).textTheme.bodyMedium;
    const TextStyle headerTextStyle = TextStyle(
      fontSize: 15,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return InkWell(
        onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RecipePage(
                        recipe: recipe,
                      )))
            },
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            // margin: const EdgeInsets.all(5),
            color: Colors.black,
            child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(20.0), // give image rounded corners
                  image: DecorationImage(
                    image: NetworkImage(recipe.imageUrl),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    opacity: 0.5,
                  ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // recipe author and favourite icon
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(recipe.recipeAuthor,
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white)),
                            const Icon(Icons.favorite,
                                color: Colors.red, size: 15),
                          ]),
                      // recipe name and icons
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(recipe.recipeName, style: headerTextStyle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                recipe.cookingTimeIcon,
                                Text(recipe.cookingTime, style: bodyTextStyle),
                                recipe.ingredientCostIcon,
                                Text(recipe.amountOfIngredients,
                                    style: bodyTextStyle),
                                recipe.recipeDifficultyIcon,
                                Text(recipe.recipeDifficulty,
                                    style: bodyTextStyle),
                              ],
                            ),
                          ])
                    ]))));
  }
}
