import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/provider/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emaailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emaailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Enter email address"
                ),
                validator: (val){
                  if(val == null || val.isEmpty){
                    return "Email is required";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Enter password"
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (val){
                  if(val == null || val.isEmpty){
                    return "Password is required";
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              ElevatedButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  Provider.of<AuthProvider>(context,listen: false).login(context, email: _emaailController.text, password: _passwordController.text);
                }
              }, child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
