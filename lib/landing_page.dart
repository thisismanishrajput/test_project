import 'package:flutter/material.dart';
import 'package:untitled1/common/widgets/loading_widget.dart';
import 'package:untitled1/helper/SharedPreferences.dart';
import 'package:untitled1/screen/login_screen.dart';
import 'package:untitled1/screen/recipes_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AccessTokenValidator.isAlreadyLogin(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return showLoader();
          }
          if(snapshot.hasData && snapshot.data == true){
            return RecipesScreen();
          }else{
            return LoginScreen();
          }
        }
    );
  }
}
