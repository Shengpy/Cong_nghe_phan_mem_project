import 'package:flutter/material.dart';
import 'package:flutter_application_1/class/database.dart';
import '../../class/Account.dart';
import '/components/styles.dart' as style;

import 'login.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  const ResetPassword({super.key,required this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 150),
              const Text(
                "Reset Password",
                style: TextStyle(
                    fontFamily: "bold", color: style.appColor, fontSize: 50),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter new Password",
                style: TextStyle(
                    fontSize: 16, fontFamily: "medium", color: Colors.black54),
              ),
              const SizedBox(height: 35),
              TextFormField(
                controller: _controllerPassword,
                obscureText: _obscurePassword,
                focusNode: _focusNodePassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "New Password",
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
                    return "Please enter code.";
                  } else if (value.length < 5) {
                    return "Code must be at least 5 character.";
                  }
                  return null;
                },
                onEditingComplete: () =>
                    _focusNodeConfirmPassword.requestFocus(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerConFirmPassword,
                obscureText: _obscurePassword,
                focusNode: _focusNodeConfirmPassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
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
                  } else if (value != _controllerPassword.text) {
                    return "Password doesn't match.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
              Column(
                children: [
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
                        Account a=Account();
                        for (var i = 0; i < MongoDatabase.accounts.length; i++){
                          if(MongoDatabase.accounts[i].info.email==widget.email){
                            a=MongoDatabase.accounts[i];
                            break;
                          }
                        }
                        await MongoDatabase.updatePassword(a.username, _controllerPassword.text);
                        await MongoDatabase.loadData();
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 1),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            width: 200,
                            backgroundColor: Colors.pink,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            behavior: SnackBarBehavior.floating,
                            content: const Text("Reset successfully", textAlign: TextAlign.center),
                          ),
                        
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Confirm"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const Login();
                            },
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontFamily: "bold",
                              color: style.appColor,
                              fontSize: 15),
                        ),
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
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    _controllerUsername.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConFirmPassword.dispose();
    super.dispose();
  }
}