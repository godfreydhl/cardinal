import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'profile-temp.dart';
import 'login-view.dart';
import 'profile_edit_view.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(left:95),
          child: Text(
              'Profile'
          ),
        ),

      ),
      resizeToAvoidBottomInset: false,
      body:Column(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end:Alignment.bottomCenter,
                        colors:[Colors.black, Colors.grey]
                      )
                    ),
                    width: double.infinity,
                     child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/images/model.jpg'),
                              radius: 50,
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                '${User.first} ${User.last}',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white
                                )
                              ),
                            ),


                          ],
                        )
                      ),
                    ),
                  ),
              Expanded(
                flex: 2,
                child: Column(
                  children:[
                    Expanded(
                      flex:4,
                      child: ListView(
                      padding: const EdgeInsets.all(8),
                      children: <Widget>[
                        ListTile(
                          title: Text('First Name',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black
                                )
                          ),
                          subtitle: Text('${User.first}') ,
                          trailing: IconButton(
                             icon: Icon(Icons.edit),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (_){
                                      return ProfileEdit(User: User,title: 'First Name');
                                    })
                                );
                            },
                          )
                        ),
                        ListTile(
                            title: Text('Last Name',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black
                                )
                            ),
                            subtitle: Text('${User.last}') ,
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (_){
                                      return ProfileEdit(User: User,title: 'Last Name');
                                    })
                                );
                              },
                            )
                        ),

                        ListTile(
                            title: Text('Email',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black
                                )
                            ),
                            subtitle: Text('${User.email}') ,
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (_){
                                      return ProfileEdit(User: User,title: 'Email');
                                    })
                                );
                              },
                            )
                        ),
                        ListTile(
                            title: Text('Password',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black
                                )
                            ),
                            subtitle: Text('•••••'),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (_){
                                      return ProfileEdit(User: User,title: 'Password');
                                    })
                                );
                              },
                            )
                        ),
                      ]
                      ),
                    ),
                    Expanded(
                      flex:1,
                      child: Container(
                        padding: const EdgeInsets.only(left:16, top: 24),
                        child: ElevatedButton(
                          onPressed: () {Navigator.push(context, MaterialPageRoute(
                              builder: (_){
                                return Login();
                              })
                          );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 16, bottom: 16, left: 80, right: 80),
                            child: Text(
                              'LOG OUT',
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
                    ),
                    SizedBox(
                      height:30.0
                    )
                ]
                ),
              ),
            ],

      ),
      );
  }
}