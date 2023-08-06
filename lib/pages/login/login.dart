import 'package:flutter/material.dart';
import 'package:flutter_application_1/values/loginstatus.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import '/components/styles.dart' as style;

import '../../class/Account.dart';
import '../../class/database.dart';
import '../tabs.dart';
import 'forgotpassword.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  static const String id = 'login';
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  List<Account> accounts=MongoDatabase.accounts;
  late SharedPreferences prefs;

  bool _obscurePassword = true;

  bool checkUser(String a,String b,String c){
    accounts=MongoDatabase.accounts;
    for (var i = 0; i < accounts.length; i++){
      if(accounts[i].username==a){
        if(c=="username")
          {return true;}
        if(c=="password")
        {
          if (accounts[i].password==b){
            return false;
          }
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 150),
              const Text(
                "Rento app",
                style: TextStyle(
                    fontFamily: "bold",
                    color: style.appColor,
                    fontSize: 50),
              ),
              const SizedBox(height: 10),
              const Text(
                "Login to your account",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "medium",
                    color: Colors
                        .black54),
              ),
              const SizedBox(height: 60),
              TextFormField(
                controller: _controllerUsername,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onEditingComplete: () => _focusNodePassword.requestFocus(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter username.";
                  // } else if (MongoDatabase.searchData(_controllerUsername.text).username==value) {                  
                  } else if (!checkUser(value,'','username')) {
                    return "Username is not registered.";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerPassword,
                focusNode: _focusNodePassword,
                obscureText: _obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: _obscurePassword
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password.";
                    } else if (checkUser(_controllerUsername.text,value,"password")) {
                      return "Wrong password.";
                    }

                  return null;
                },
              ),
              const SizedBox(height: 60),
              Column(
                children: [
                  //------------------------------------Login button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: style.appColor,
                      // onPrimary: Colors.white,
                      minimumSize: const Size.fromHeight(30), //50
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ), 
                    ),
                    onPressed: () async{
                      if (_formKey.currentState?.validate() ?? false) {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString(MyAccount.username, _controllerUsername.text);

                        if (!mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const TabsExample();
                            },
                          ),
                        );
                        
                      }
                    },
                    child: const Text("Login"),
                  ),
                  //----------------------------------------------Sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          _formKey.currentState?.reset();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Signup();
                              },
                            ),
                          );
                        },
                        child: const Text("Signup",
                        style: TextStyle(
                              fontFamily: "bold",
                              color: style.appColor,
                              fontSize: 15),),
                      ),
                      //---------------------------------Forgot password
                      TextButton(
                        onPressed: () {
                          _formKey.currentState?.reset();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ForgotPassword();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Password",
                          style: TextStyle(
                              fontFamily: "bold",
                              color: style.appColor,
                              fontSize: 15),),
                      ),
                    ],
                  ),                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
