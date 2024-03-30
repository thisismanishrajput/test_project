import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/common/widgets/loading_widget.dart';
import 'package:untitled1/model/recipe_model.dart';
import 'package:untitled1/provider/login_provider.dart';
import 'package:untitled1/provider/reciepe_provider.dart';
import 'package:untitled1/screen/details_screen.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<RecipeProvider>(context, listen: false).fetchRecipe(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          if(provider.isRecipeLocading) return showLoader();
          if(provider.recipeList.isEmpty) return Center(child: Text("No data found"));
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: TextFormField(
                        controller: _searchController,
                        onChanged: (val){
                          Provider.of<RecipeProvider>(context,listen: false).searchRecepie(query: _searchController.text);
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    Provider.of<AuthProvider>(context,listen: false).logout(context);
                  }, child: Text("Sign Out"))
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:_searchController.text.isEmpty ? provider.recipeList.length:provider.searchList.length,
                    itemBuilder: (context,index){
                      Recipe recipe =_searchController.text.isEmpty ? provider.recipeList[index]:provider.searchList[index];
                  return recipeCard(recipe: recipe);
                }),
              ),
            ],
          );
        },
      ),
    );
  }
  Widget recipeCard({required Recipe recipe}){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RecipeDetailsScreen(recipe: recipe)));
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10)
        ),
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(recipe.image))
              ),
            ),
            Text(recipe.name),
            Text("Ingredients",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
            for(int i =0;i<recipe.ingredients.length;i++)
              Text(recipe.ingredients[i],style: TextStyle(
      
              ),)
          ],
        ),
      ),
    );
  }
}
