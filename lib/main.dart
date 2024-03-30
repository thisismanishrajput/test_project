import 'package:flutter/material.dart';
import 'package:untitled1/landing_page.dart';
import 'package:untitled1/provider/login_provider.dart';
import 'package:untitled1/provider/reciepe_provider.dart';
import 'package:untitled1/screen/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/screen/recipes_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthImpl()),
        ChangeNotifierProvider<RecipeProvider>(create: (_) => RecipeImpl()),
      ],
      child:  MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LandingPage(),
      ),
    );
  }
}
