import 'package:flutter/material.dart';
import 'package:recipeapp/main.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key, required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(recipe.recipeName,
              style: const TextStyle(
                fontSize: 15,
              )),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {},
            ),
            // add more IconButton
          ],
        ),
        body: Column(children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(recipe.imageUrl),
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
              ),
            ),
          ),
          Expanded(
            // https://stackoverflow.com/questions/73484571/flutter-keep-certain-elements-fixed-during-scrolling
            // TODO: figure out why Expanded is needed
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // recipe author
                      Row(
                        children: [
                          const Text('Author: ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(width: 3),
                          Text(recipe.recipeAuthor,
                              style: const TextStyle(
                                fontSize: 12,
                              )),
                        ],
                      ),

                      // recipe description
                      const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Description: ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(recipe.description,
                              style: const TextStyle(
                                fontSize: 12,
                              )),
                        ],
                      ),

                      // recipe ingredients
                      const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Ingredients: ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          Wrap(
                            // using Wrap instead of Row helped with overflow
                            direction: Axis.horizontal,
                            // alignment: WrapAlignment.spaceAround,
                            children: [
                              for (var i = 1;
                                  i < recipe.ingredients.length + 1;
                                  i++)
                                Text('$i. ${recipe.ingredients[i - 1]} ',
                                    style: const TextStyle(
                                      fontSize: 12,
                                    )),
                            ],
                          ),
                        ],
                      ),

                      // recipe time
                      const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Time to Cook: ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          Text('${recipe.cookTime} min',
                              style: const TextStyle(
                                fontSize: 12,
                              )),
                        ],
                      ),

                      // recipe directions
                      const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Directions: ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 1;
                                  i < recipe.directions.length + 1;
                                  i++)
                                Text('$i. ${recipe.directions[i - 1]} ',
                                    style: const TextStyle(
                                      fontSize: 12,
                                    )),
                            ],
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          )
        ]));
  }
}
