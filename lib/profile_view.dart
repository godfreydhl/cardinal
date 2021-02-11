import 'package:flutter/material.dart';
import 'profile-temp.dart';
import 'login-view.dart';

class Profile extends StatelessWidget {
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
      body: Column(
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
              child: Container(
                width: double.infinity,
                height: 150.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/model.jpg'),
                        radius: 70,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${User.first} ${User.last}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white
                        )
                      ),


                    ],
                  )
                ),
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
                      leading: Icon(Icons.person,
                      color: Colors.black,),
                      title: Text('Name',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black
                            )
                      ),
                      subtitle: Text('${User.first} ${User.last}') ,
                      trailing: IconButton(
                         icon: Icon(Icons.edit),
                          onPressed: (){
                           null;
                        },
                      )
                    ),

                    ListTile(
                        leading: Icon(Icons.email,
                            color: Colors.black),
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
                            null;
                          },
                        )
                    ),
                    ListTile(
                        leading: Icon(Icons.lock,
                            color: Colors.black),
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
                            null;
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