import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/api/api.dart';
import 'package:untitled1/helper/SharedPreferences.dart';
import 'package:untitled1/landing_page.dart';
import 'package:untitled1/model/login_model.dart';
import 'package:untitled1/screen/recipes_screen.dart';


abstract class AuthProvider extends ChangeNotifier {

  Future<void> login(BuildContext context,{required String email,required String password});
  Future<void> logout(BuildContext context);

}

class AuthImpl extends ChangeNotifier implements AuthProvider {
  final Dio _dio = Dio();


  @override
  Future<void> login(BuildContext context,{required String email,required String password}) async {
    try {

      var response = await _dio.post(
        "https://dummyjson.com/auth/login",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        data: json.encode({
          "username":email,
          "password":password
        })
      );
      if (response.statusCode == 200) {
        LoginModel loginModel = LoginModel.fromJson(response.data);
        saveUserData(
            firstName: loginModel.firstName,
            lastName: loginModel.lastName,
            email: loginModel.email,
            gender: loginModel.gender,
            image: loginModel.image,
            token: loginModel.token
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RecipesScreen()));
        notifyListeners();
      }

    } on DioException catch (e) {
      print("Exception is  ${e}");
      rethrow;
    }


  }

  Future<void> logout(BuildContext context)async{
    AccessTokenValidator.clearToken();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LandingPage()));
  }
}
