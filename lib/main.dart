import 'package:flutter/material.dart';
import 'home.dart';
import 'Store-view.dart';
import 'package:cardinal/Bookmarks-view.dart';
import 'login-view.dart';
import 'profile_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
      ),
      home: Login(),
    );
  }
}

class MyHomePage extends StatefulWidget{

  @override
  _MyHomePageState createState() => _MyHomePageState();

}
class _MyHomePageState extends State <MyHomePage>{
  int _selectedIndex =0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static  List<Widget> _widgetOptions = <Widget>[
    TabbedPage(),
    Bookmarks(),
    Store(),
    Profile(),
  ];

  void _onItemTapped(int index){
    setState((){
      _selectedIndex = index;
    });
  }

  void get onItemtapped => _onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:_widgetOptions.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
              icon:Icon(Icons.home_outlined),
              label:'Home'
          ),
          BottomNavigationBarItem(

              icon: Icon(Icons.bookmark_border),
              label: 'Bookmarked'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.store_outlined),
              label:'Store'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: 'Account'
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showSelectedLabels: false,

      ),

    );
  }
}
