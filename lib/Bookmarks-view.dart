import 'package:cardinal/article-view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Article.dart';
class Bookmarks extends StatefulWidget {


  @override
  _BookmarksState createState() => _BookmarksState();
}


class _BookmarksState extends State<Bookmarks> {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> removeBookmark(article)async {

    CollectionReference bookmarks = FirebaseFirestore.instance.collection('${article.type}')
        .doc('${article.title}').collection('Bookmarks');
    // Call the user's CollectionReference to add a new user

    CollectionReference userBookmarks = FirebaseFirestore.instance.collection('Users')
        .doc('${userId}').collection('Bookmarks');


    bookmarks
        .doc('$userId')
        .delete()
        .then((value) => {
    })
        .catchError((error) => print("Failed to delete bookmark: $error"));

    userBookmarks
        .doc('${article.title}')
        .delete()
        .then((value)=> {
    })
        .catchError((error) => print("Failed to add bookmark: $error"));
  }

  Widget _buildBody(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child:Text(
            'Saved Articles'
          )
        ),
      ),
      body: StreamBuilder <QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').doc('${userId}').collection('Bookmarks').snapshots(),
        builder: (context, snapshot){

          if (snapshot.hasError) {
            return Center(
                child: Text('Something went wrong')
            );
          }

          if(!snapshot.hasData) {
            return Center(
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return _buildList(context, snapshot.data!.docs);
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot){
    return ListView(
      padding: const EdgeInsets.only(top:20.0),
      children: snapshot.map((data) => _buildBookmark(context, data)).toList(),
    );
  }


  Widget _buildBookmark(BuildContext context, DocumentSnapshot data){
    final article = Article.fromSnapshot(data);

    Future<String> _url =  firebase_storage.FirebaseStorage.instance
        .ref()
        .child(article.image)
        .getDownloadURL();
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (_){
              return ArticleView(article: article);
            })
        );
      },
      child: FutureBuilder<String>(
          future: _url,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
            if(snapshot.hasData){
              return Card(
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Image.network(snapshot.data.toString()),
                        )
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top:8, left: 8),
                            child: Text(
                              article.title,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top:8, left: 8),
                            child: Text('Saved on ${DateFormat.yMMMd().format(article.dateBookmarked)} '/*${formatDate(article.dateBookmarked, [dd, ' ', M, ' ', yyyy])}'*/
                              ,
                              style: TextStyle(
                                  color:Colors.grey
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: (){
                                    setState(() {
                                      removeBookmark(article);
                                    });

                                  }
                              ),
                              IconButton(
                                  icon: Icon(Icons.share, color: Colors.red,),
                                  onPressed: null)
                            ],
                          )// fix article bookmark date ?
                        ],
                      ),
                    )
                  ],
                ),
              );

            }
            else if(snapshot.hasError){
              return Icon(Icons.error_outline);
            }
            else return Center(
                  child: Container(
                      padding: EdgeInsets.only(top: 32),
                      child: CircularProgressIndicator(strokeWidth: 0.3,)
                  )
              );

          }
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: _buildBody(context)
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}