import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'article-view.dart';
class SearchView extends StatefulWidget{


  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {

  String userId = FirebaseAuth.instance.currentUser!.uid;


  @override
  List<Widget> buildActions(BuildContext context) {
    return [(
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        )
    )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,

      ),
      onPressed: () {
        close(context, "close");
      },

    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    CollectionReference userSearchHistory = FirebaseFirestore.instance.collection('Users')
        .doc('${userId}').collection('Search_History');

    return StreamBuilder<QuerySnapshot>(
        stream: query.isEmpty? userSearchHistory.snapshots():
        FirebaseFirestore.instance.collection('Travel_Articles').snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(!snapshot.hasData) {
            return Center(
                child : Text(
                    "No recent searches",
                    style: TextStyle(
                        fontSize: 40
                    )
                )
            );
          }

          if (snapshot.hasError) {
            return Center(
                child: Text('Something went wrong')
            );
          }

          final results = query.isEmpty
              ? snapshot.data!
              .docs
              .map((doc)=>doc['title'])
              .toList()
              : snapshot.data!
              .docs
              .map((doc)=>doc['title'])
              .where((doc) =>doc.contains(query))
              .toList();

          return ListView.builder(
            itemCount:results.length,
            itemBuilder:(context, index) =>
                ListTile(
                  onTap: (){
                    query = results[index];

                    userSearchHistory
                        .where('title', isEqualTo: query)
                        .get()
                        .then((QuerySnapshot snapshot){
                      if(snapshot.docs.isEmpty){
                        userSearchHistory
                            .doc('${query}')
                            .set({
                          'title':'${query}'
                        }).then((value)=> {

                        }).catchError((error) => print("Failed to add search item: $error"));
                      }});

                    showResults(context);
                    },
                  leading: query.isEmpty
                      ? Icon(Icons.history)
                      : Icon(Icons.search) ,
                  title: Text(results[index]),
                ),

          );
    }
    );
  }

  Widget buildResults(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Travel_Articles').snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Something went wrong')
            );
          }


          final results =  snapshot.data!
              .docs
              .map((doc)=>doc['title'])
              .where((doc) =>doc.contains(query))
              .toList();

          return ListView.builder(
            itemCount:results.length,
            itemBuilder:(context, index) =>
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (_) {
                          return ArticleView(article: results[index]);
                        })
                    );
                  },
                  leading:Icon(Icons.article) ,
                  title: Text(results[index]),
                ),

          );
        }
    );
  }
}