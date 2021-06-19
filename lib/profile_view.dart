import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    User user = FirebaseAuth.instance.currentUser!;

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

          children: [
            Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left:16, top:16),
                    alignment: Alignment.topLeft,
                    child: Text(
                      user.email!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 16, left:16),
                    alignment: Alignment.topLeft,
                    child: Text(
                        user.displayName!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.black)
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: OutlinedButton(
                      onPressed: null,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            )
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                  'Subscibe and get the latest issues first',
                                  style:TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20,
                                      color: Colors.black
                                  )
                              ),
                            ),
                            Expanded(
                              flex:2,
                              child: Icon(
                                Icons.menu_book,
                                size: 70,
                                color: Colors.red[700],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                ]
            ),
            Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ListTile(
                            title: Text(
                              'Account',
                              style:TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black
                              ),
                            ),
                            trailing: IconButton(
                              icon:Icon(
                                Icons.arrow_forward_ios,
                                size: 13,
                              ),
                              onPressed: (){

                              },
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'About Us',
                              style:TextStyle(
                                  fontSize: 18,
                                  color: Colors.black
                              ),
                            ),
                            trailing: IconButton(
                              icon:Icon(
                                Icons.arrow_forward_ios,
                                size: 13,
                              ),
                              onPressed: (){

                              },
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Privacy Policy',
                              style:TextStyle(
                                  fontSize: 18,
                                  color: Colors.black
                              ),
                            ),
                            trailing: IconButton(
                              icon:Icon(
                                Icons.arrow_forward_ios,
                                size: 13,
                              ),
                              onPressed: (){

                              },
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Terms and Conditions',
                              style:TextStyle(
                                  fontSize: 18,
                                  color: Colors.black
                              ),
                            ),
                            trailing: IconButton(
                              icon:Icon(
                                Icons.arrow_forward_ios,
                                size: 13,
                              ),
                              onPressed: (){

                              },
                            ),
                          ),
                        ]
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                        padding: const EdgeInsets.only(left:16, top: 24),
                        child: OutlinedButton(
                          onPressed:() {
                            FirebaseAuth.instance.signOut();
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
                        )
                    ),
                  ),
                ]
            ),
          ]
      ),
    );
  }


}