
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'authentication.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'issue_download_button.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context) => ApplicationState()),
        ChangeNotifierProvider(create: (context) => ButtonState()),

      ],
      builder: (context, _)=>MyApp(),
    ),

  );
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print(snapshot.error);
          return MaterialApp(
              theme: ThemeData(
                primaryColor: Colors.black,
                accentColor: Colors.black,
              ),
              home: somethingWentWrong()
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            theme: ThemeData(
              primaryColor: Colors.black,
              accentColor: Colors.black,
            ),
            home: MainController()
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(child: CircularProgressIndicator());
      },
    );

  }
}

class somethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Something went wrong dude'),
      ),
    );
  }

}

class MainController extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<ApplicationState>(
        builder: (context, appState, _) => Authentication(
          email: appState.email,
          loginState: appState.loginState,
          startLoginFlow: appState.startLoginFlow,
          verifyEmail: appState.verifyEmail,
          signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
          cancelRegistration: appState.cancelRegistration,
          registerAccount: appState.registerAccount,
          signOut: appState.signOut,
          startRegistration: appState.startRegistration,

        ),
      ),
    );
  }

}

class ApplicationState extends ChangeNotifier {

  int _attendees = 0;
  int get attendees => _attendees;

  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        notifyListeners();

      } else {
        _loginState = ApplicationLoginState.loggedOut;
      }
      notifyListeners();
    });
  }
  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState =>_loginState;

  String? _email;
  String? get email => _email;

  void startLoginFlow(){
    _loginState = ApplicationLoginState.loggedOut;
    notifyListeners();
  }

  void verifyEmail(
      String email,
      void Function(FirebaseAuthException e) errorCallback,
      ) async {
    try {
      var methods =
      await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.loggedOut;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signInWithEmailAndPassword(
      String email,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }


  void cancelRegistration(){
    _loginState = ApplicationLoginState.register;
    notifyListeners();
  }
  void startRegistration(){
    _loginState = ApplicationLoginState.register;
    notifyListeners();
  }
  void registerAccount(String displayName, String email,  String password,
      void Function(FirebaseAuthException e) errorCallback) async{
    try{
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateProfile( displayName: displayName);
    } on FirebaseAuthException catch (e){
      errorCallback(e);
    }
  }

  void signOut(){
    FirebaseAuth.instance.signOut();
  }

}
