import 'package:flutter/material.dart';
import 'profile-temp.dart';

class ProfileEdit extends StatefulWidget{

  final Profile User;
  final String title;

  const ProfileEdit({Key key, this.User, this.title}) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {

  Future<void> _showEmailDialog(String newValue) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You have changed your email'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Send Confirmation email to this address:'),
                Text('${newValue}')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showPasswordDialog(String newValue) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Verify new Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                    autofocus: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Passwword',
                    ),
                    onSaved: (String value){
                      widget.User.newPassword = value;
                    },
                    validator: (String value){
                      String result;

                      if(value.isEmpty){
                        result = 'email cannot be empty';
                      }
                      else if(!value.contains('@')){
                        result = 'Please enter a valid email';
                      }
                      else if(value!= newValue){
                        result = 'Passwords do not match';
                      }
                      else {
                        null;
                      }
                      return result;
                    }
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Save'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String newValue;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child:Text('${widget.title}')
        ),
        leading: IconButton(
          icon:Icon(Icons.close),
          onPressed: (){
            Navigator.pop(context);
          },

        ),
        actions: [
            IconButton(
            icon:Icon(Icons.check),
            onPressed: (){
              if(widget.title=='First Name'){
                widget.User.firstName = myController.text;
                Navigator.pop(context);
              }

              else if(widget.title=='Last Name'){
                widget.User.lastName = myController.text;
                Navigator.pop(context);
              }
              else if(widget.title=='Email'){
                widget.User.newEmail = myController.text;
                _showEmailDialog(myController.text);

              }
              else if(widget.title=='Password'){
                _showPasswordDialog(myController.text);

              }
              else{
                null;
              }
            }

            ),
        ],
      ),

       body: Container(
         padding: const EdgeInsets.all(16),
         child: TextFormField(
                     autofocus: true,
                     decoration: InputDecoration(
                       labelText: '${widget.title}',
                     ),
                     autocorrect: true,
                     onSaved: (String value){
                       value = newValue;
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
                     }
         ),
       ),
    );
  }
}