import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/api/api.dart';
import 'package:untitled1/helper/SharedPreferences.dart';
import 'package:untitled1/model/recipe_model.dart';


abstract class RecipeProvider extends ChangeNotifier {
  List<Recipe> get recipeList;
  List<Recipe> get searchList;
  bool get isRecipeLocading;
  Future<void> fetchRecipe(BuildContext context);
  void searchRecepie({required String query});
}

class RecipeImpl extends ChangeNotifier implements RecipeProvider {
  final Dio _dio = Dio();

  bool _isRecipeLoading = false;

  @override
  bool get isRecipeLocading => _isRecipeLoading;

  List<Recipe> _productList = [];

  @override
  List<Recipe> get recipeList => _productList;

  addProductToList({required List<Recipe> list}) {
    _productList.addAll(list);
    _isRecipeLoading = false;
    notifyListeners();
  }

  List<Recipe> _searchList = [];
  List<Recipe> get searchList => _searchList;

  @override
  Future<void> fetchRecipe(BuildContext context) async {
    try {
      _isRecipeLoading = true;
      var response = await _dio.get(
        API.recipes,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        print("Response is ${response.data}");
        addProductToList( list: RecipeModel.fromJson(response.data).recipes);
        notifyListeners();
      }

    } on DioException catch (e) {
      rethrow;
    } finally {
      if (_isRecipeLoading  ) {
        _isRecipeLoading = false;
        notifyListeners();
      }

    }
  }

  void searchRecepie({required String query}){
    for(int i =0 ;i<_productList.length;i++){
      if(_productList[i].name.contains(query)){
        _searchList.add(_productList[i]);
        notifyListeners();
      }
    }
    print("After Search list is ${_searchList.length}");
    notifyListeners();
  }
}
