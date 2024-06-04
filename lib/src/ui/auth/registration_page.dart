import 'package:flutter/material.dart';

import '../../config/styles/palette.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _registerFormKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();
  String? _name, _registerEmail, _registerPassword;
  String? _loginEmail, _loginPassword;
  bool _isLogin = false;

  void _tryRegister() {
    if (_registerFormKey.currentState!.validate()) {
      _registerFormKey.currentState!.save();
      // Handle registration logic here
      print(
          'Register with name: $_name, email: $_registerEmail, password: $_registerPassword');
    }
  }

  void _tryLogin() {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      // Handle login logic here
      print('Login with email: $_loginEmail, password: $_loginPassword');
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
                                    child: Center(child: Text('Signup')),
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
