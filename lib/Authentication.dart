import 'package:flutter/material.dart';
import 'widgets.dart';
import 'mainDisplay.dart';
import 'login-view.dart';
import 'register-view.dart';



enum ApplicationLoginState {
  loggedOut,
  register,
  loggedIn,
}

class Authentication extends StatelessWidget {
  const Authentication({
    required this.loginState,
    required this.email,
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
    required this.signOut,
    required this.startRegistration,

  });

  final ApplicationLoginState loginState;
  final String? email;
  final void Function() startLoginFlow;
  final void Function(
      String email,
      void Function(Exception e) error,
      ) verifyEmail;
  final void Function(
      String email,
      String password,
      void Function(Exception e) error,
      ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function(
      String email,
      String displayName,
      String password,
      void Function(Exception e) error,
      ) registerAccount;
  final void Function() signOut;
  final void Function() startRegistration;

  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedOut:
        return LoginForm(
            login: (email, password) {
              signInWithEmailAndPassword(email, password,
                      (e) => _showErrorDialog(context, 'Failed to sign in', e));
            },
            registration: (){
              startRegistration();
            }
        );
      case ApplicationLoginState.register:
        return RegisterForm(
          loginFlow: (){
            startLoginFlow();
          },
          cancel: () {
            cancelRegistration();
          },
          registerAccount: (
              displayName,
              email,
              password,
              ) {
            registerAccount(
                displayName,
                email,
                password,
                    (e) =>
                    _showErrorDialog(context, 'Failed to create account', e));
          },
        );
      case ApplicationLoginState.loggedIn:
        return MyHomePage(
            logout: (){
              signOut();
            }
        );
      default:
        return Row(
          children: [
            Text("Internal error, this shouldn't happen..."),
          ],
        );
    }
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            StyledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }
}






