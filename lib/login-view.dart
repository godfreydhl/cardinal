import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  LoginForm({
    required this.login,
    required this.registration
  });

  final void Function(String email, String password) login;
  final void Function() registration;
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_PasswordFormState');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(

          child: Form(
            key:_formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(8) ,
                    child: Image.asset('assets/images/logo.jpg')
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
                            color:Colors.white,
                          )
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width:2,
                              color: Colors.white)
                      ),
                      icon: Icon(Icons.person, color: Colors.white),
                      labelText: 'email',
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your email address to continue';
                      }
                      else if(!value.contains('@')){
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
                              color:Colors.white,

                            )
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width:2,
                                color: Colors.white)
                        ),

                        icon: Icon(Icons.lock, color: Colors.white,),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        suffixIcon: IconButton(
                          icon:Icon(Icons.remove_red_eye, color: Colors.white),
                          onPressed: (){
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                        )
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your password';
                      }
                      else return null;
                    },
                    obscureText: _hidePassword,
                  ),
                ),
                TextButton(
                  child: Text('Forgot your password?',
                    style: TextStyle(
                        color: Colors.white
                    ),),
                  onPressed: (){

                  },
                ),
                Container(
                  padding: const EdgeInsets.only(left:16, top: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        widget.login(
                            _emailController.text,
                            _passwordController.text
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 80, right: 80),
                      child: Text(
                        'LOG IN',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    ),
                  ),
                ),
                TextButton(
                  child: Text('Don\'t have an account? Sign Up',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  onPressed: (){
                    widget.registration();
                  },
                ),
              ],
            ),
          )
      ),
    );
  }
}