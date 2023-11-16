import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:spims/common/app_colors.dart';
import 'package:spims/common/current_user.dart';
import 'package:spims/pages/home_page.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showError = false;
  bool showApiError = false;
  bool isPasswordVisible = false;

  void onLoginSuccess() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Center(
        child: Container(
          width: 400,
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: AppColor.cardprimary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      color: showError ? Colors.red : AppColor.grey,
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.person,
                        color: AppColor.black,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  controller: usernameController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: showError ? Colors.red : AppColor.grey,
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.lock,
                        color: AppColor.black,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColor.grey,
                      ),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  controller: passwordController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      validateUser();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                if (showApiError) ...{
                  const SizedBox(height: 20),
                  const Text(
                    'Unable to connect to the server.',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                }
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> validateUser() async {
    setState(() {
      showError = false;
      showApiError = false;
    });

    final username = usernameController.text;
    final password = passwordController.text;

    var apiUrl = 'http://localhost:8000/user/users/$username';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final apiUsername = responseData['username'];
        final apiPassword = responseData['password'];

        if (apiUsername == username && apiPassword == password) {
          await saveLoginInfo(username, password);
          onLoginSuccess();
        } else {
          clearInputData();
        }
      } else {
        clearInputData();
      }
    } catch (e) {
      clearInputData();
    }
  }

  void clearInputData() {
    setState(() {
      usernameController.clear();
      passwordController.clear();
    });
  }

  Future<void> saveLoginInfo(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);

    await fetchUserData();
  }
}
