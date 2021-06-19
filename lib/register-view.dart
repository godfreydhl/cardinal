import 'package:flutter/material.dart';



class RegisterForm extends StatefulWidget {
  RegisterForm({
    required this.cancel,
    required this.registerAccount,
    required this.loginFlow,

  });
  //final String email;
  final void Function(String displayName, String email,  String password)
  registerAccount;
  final void Function() loginFlow;
  final void Function() cancel;
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
  final _emailController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  bool _hidePassword = true;

  @override
  void initState() {
    super.initState();
  }

  Widget _body() {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 128, bottom: 16, left: 16, right: 16),
                child: TextFormField(
                  controller: _displayNameController,
                  cursorColor: Colors.white,
                  autocorrect: true,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        )
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            color: Colors.white)
                    ),
                    icon: Icon(Icons.person, color: Colors.white),
                    labelText: 'username',
                    labelStyle: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your username to continue';
                    }
                    else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: _emailController,
                  cursorColor: Colors.white,
                  autocorrect: true,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,

                        )
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            color: Colors.white)
                    ),
                    icon: Icon(Icons.mail, color: Colors.white),
                    labelText: 'email',
                    labelStyle: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your email address to continue';
                    }
                    else if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    else if (!value.contains('.')) {
                      return 'Please enter a valid email';
                    }
                    else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: _passwordController,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          )
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Colors.white)
                      ),
                      icon: Icon(Icons.lock, color: Colors.white,),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                      )
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your password';
                    }
                    else
                      return null;
                  },
                  obscureText: _hidePassword,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: _password2Controller,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          )
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Colors.white)
                      ),
                      icon: Icon(Icons.lock, color: Colors.white,),
                      labelText: 'Verify Password',
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                      )
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Verify password';
                    }
                    else if (value != _passwordController.text) {
                      return 'Password does not match';
                    }
                    else
                      return null;
                  },
                  obscureText: _hidePassword,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, top: 24),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.registerAccount(
                        _displayNameController.text,
                        _emailController.text,
                        _passwordController.text,
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 80, right: 80),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.red),
                  ),


                ),
              ),
              TextButton(
                child: Text('Already have an account? Sign In',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onPressed: () {
                  widget.loginFlow();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: _body()
    );
  }
}