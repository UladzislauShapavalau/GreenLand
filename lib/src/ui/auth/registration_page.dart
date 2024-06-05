import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greenland/main.dart';
import 'package:greenland/src/ui/add_plant/add_reminder_widget.dart';

import '../../config/styles/palette.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  static late String username;

  final _registerFormKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();
  String? _name, _registerEmail, _registerPassword;
  String? _loginEmail, _loginPassword;
  bool _isLogin = false;

  void _tryRegister() async {
    if (_registerFormKey.currentState!.validate()) {
      _registerFormKey.currentState!.save();

      final url = 'http://localhost:8000/api/register';
      final headers = {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        HttpHeaders.accessControlAllowOriginHeader: '*'
      };
      final body = json.encode({
        'name': _name,
        'email': _registerEmail,
        'password': _registerPassword,
      });

      try {
        final response =
            await http.post(Uri.parse(url), headers: headers, body: body);

        if (response.statusCode == 200) {
          // Handle successful registration
          print('Registration successful');
        } else {
          // Handle registration error
          print('Registration failed: ${response.body}');
        }
      } catch (error) {
        // Handle any errors
        print('Error: $error');
      }
    }
  }

  void _tryLogin() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();

      final url = 'http://localhost:8000/api/login';
      final headers = {'Content-Type': 'application/json'};
      final body = json.encode({
        'email': _loginEmail,
        'password': _loginPassword,
      });

      try {
        final response =
            await http.post(Uri.parse(url), headers: headers, body: body);

        if (response.statusCode == 200) {
          // Parse the JSON response to get the token
          final responseData = json.decode(response.body);
          final token = responseData['token'];
          username = _loginEmail!;

          // Save the token using shared_preferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', token);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );

          print('Login successful, token saved: $token');
          // You can now use the token for future API calls
        } else {
          // Handle login error
          print('Login failed: ${response.body}');
        }
      } catch (error) {
        // Handle any errors
        print('Error: $error');
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Image.asset(
                'icons/registrationplant.png',
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 130.0, horizontal: 160.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('/icons/icon_logo.png',
                                width: 40, height: 40, fit: BoxFit.fill),
                            const SizedBox(width: 8),
                            Text(
                              'Greenland',
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Text(
                          'Get Started Now',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        if (!_isLogin)
                          Form(
                            key: _registerFormKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: 'admin',
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _name = value;
                                  },
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  initialValue: 'admin@admin.com',
                                  decoration: InputDecoration(
                                    labelText: 'Email address',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: _validateEmail,
                                  onSaved: (value) {
                                    _registerEmail = value;
                                  },
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  initialValue: 'admin',
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder(),
                                  ),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _registerPassword = value;
                                  },
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: true,
                                      onChanged: (value) {},
                                    ),
                                    Text('I agree to the '),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        'terms & policy',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: 300,
                                  child: ElevatedButton(
                                    onPressed: _tryRegister,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Palette.navBarColor,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 18.0),
                                      textStyle: TextStyle(fontSize: 18),
                                      foregroundColor: Colors.white,
                                    ),
                                    child: Center(child: Text('Sign up')),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (_isLogin)
                          Form(
                            key: _loginFormKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: 'admin@admin.com',
                                  decoration: InputDecoration(
                                    labelText: 'Email address',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _loginEmail = value;
                                  },
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  initialValue: 'admin',
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder(),
                                  ),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _loginPassword = value;
                                  },
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: 300,
                                  child: ElevatedButton(
                                    onPressed: _tryLogin,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Palette.navBarColor,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 18.0),
                                      textStyle: TextStyle(fontSize: 18),
                                      foregroundColor: Colors.white,
                                    ),
                                    child: Center(child: Text('Login')),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: Text('Or'),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {},
                              icon: Image.network(
                                'https://img.icons8.com/color/48/000000/google-logo.png',
                                height: 24.0,
                                width: 24.0,
                              ),
                              label: Text('Sign in with Google'),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 24.0),
                              ),
                            ),
                            OutlinedButton.icon(
                              onPressed: () {},
                              icon: Image.network(
                                'https://img.icons8.com/ios-filled/50/000000/mac-os.png',
                                height: 24.0,
                                width: 24.0,
                              ),
                              label: Text('Sign in with Apple'),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 24.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(
                              _isLogin
                                  ? 'Don\'t have an account? Sign up'
                                  : 'Have an account? Sign In',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
