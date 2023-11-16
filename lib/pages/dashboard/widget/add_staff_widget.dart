import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:spims/common/app_colors.dart';
import 'package:spims/common/email_service.dart';
import 'package:spims/common/options.dart';

import '../../../common/app_font_size.dart';

class AddStaffWidget extends StatefulWidget {
  const AddStaffWidget({super.key});

  @override
  _AddStaffWidgetState createState() => _AddStaffWidgetState();
}

class _AddStaffWidgetState extends State<AddStaffWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _selectedRole = 'Staff';
  bool _isPasswordVisible = false;

  InputDecoration inputDecoration(String labelText, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: AppColor.grey),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColor.grey, width: 0.7),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColor.primary, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColor.error, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColor.error, width: 0.7),
      ),
      suffixIcon: suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Card(
          color: AppColor.white,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Add User',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: inputDecoration('Username'),
                        style: const TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: inputDecoration(
                          'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColor.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: inputDecoration('Email'),
                        style: const TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: _selectedRole,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedRole = newValue!;
                          });
                        },
                        dropdownColor: AppColor.white,
                        items: users.map((option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(
                              option,
                              style: TextStyle(
                                  fontSize: FontSize.bodyFontSize(context),
                                  color: AppColor.black),
                            ),
                          );
                        }).toList(),
                        decoration: inputDecoration('Role'),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            createUser(
                                username: _usernameController.text,
                                password: _passwordController.text,
                                selectedRole: _selectedRole,
                                email: _emailController.text);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColor.primary),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(vertical: 6),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: AppColor.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> createUser(
    {required String username,
    required String password,
    required String selectedRole,
    required String email}) async {
  const url = 'http://127.0.0.1:8000/user/users/';
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: '''
        {
          "username": "$username",
          "password": "$password",
          "role": "${selectedRole.toLowerCase()}"
        }
      ''',
  );

  if (response.statusCode == 200) {
    sendEmail(email, username, password);
  } else {
    // Error occurred while creating the user
    print('Error creating user. Status code: ${response.statusCode}');
  }
}
