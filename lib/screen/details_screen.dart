import 'package:flutter/material.dart';
import 'package:untitled1/model/recipe_model.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({super.key,required this.recipe});
final Recipe recipe;
  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.recipe.name}"),),
      body: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height*0.3,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(widget.recipe.image))
            ),
          ),
          SizedBox(height: 20),
          Text(widget.recipe.name),
          SizedBox(height: 20),
          Text("Ingredients",style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 8),
          for(int i =0;i<widget.recipe.ingredients.length;i++)
            Text(widget.recipe.ingredients[i]),

          SizedBox(height: 20),
          Text("Meal Type",style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 8),
          for(int i =0;i<widget.recipe.mealType.length;i++)
            Text(widget.recipe.mealType[i]),

          SizedBox(height: 20),
          Text("cuisine",style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 8),
            Text(widget.recipe.cuisine),

        ],
      ),
    );

  }
}
