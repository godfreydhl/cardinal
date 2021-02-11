import 'package:flutter/material.dart';
import 'main.dart';

class Login extends StatefulWidget{

  _LoginState createState() => _LoginState();



}
class _LoginState extends State<Login>{
  String _password;
  String _email;
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Container(

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
                  onSaved: (String value){
                    _email = value;
                  },
                  validator: (String value){
                    String result;

                    if(value.isEmpty){
                      result = 'email cannot be empty';
                    }
                    else if(!value.contains('@')){
                      result = 'Please enter a valid email';
                    }
                    else {
                      null;
                    }

                    return result;
                  },

                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
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
                    labelText: 'password',
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
                  onSaved: (String value){
                    _password = value;
                  },
                  validator: (String value){
                    String result;

                    if(value.isEmpty){
                      result = 'password cannot be empty';
                    }

                    return result;
                  },
                  obscureText: _hidePassword,


                ),
              ),
              FlatButton(
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
                  onPressed: () {Navigator.push(context, MaterialPageRoute(
                      builder: (_){
                        return MyHomePage();
                      })
                  );
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
              FlatButton(
                child: Text('Don\'t have an account? Sign Up',
                  style: TextStyle(
                      color: Colors.white
                  ),
                 ),
                onPressed: (){

                },
              ),





            ],
          )
      ),
    );
  }

}