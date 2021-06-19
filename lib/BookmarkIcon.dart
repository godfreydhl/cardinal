import 'package:flutter/material.dart';

import 'Article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class BookmarkIcon extends StatefulWidget{

  Article article;

  BookmarkIcon({required this.article});


  @override

  _BookmarkIconState createState() => _BookmarkIconState();

}

class _BookmarkIconState extends State<BookmarkIcon>{

  String userId = FirebaseAuth.instance.currentUser!.uid;
  late Future<bool> isbookmarked;

  @override
  void initState(){

     isbookmarked =  checkBookmark(widget.article);
  }



  Future<bool>checkBookmark(article) async{
    bool bookmark = false;
    CollectionReference bookmarks = FirebaseFirestore.instance.collection('${article.type}')
        .doc('${article.title}').collection('Bookmarks');

    bookmarks
        .where('id', isEqualTo: userId)
        .get()
        .then((QuerySnapshot snapshot){
      if(snapshot.docs.isEmpty){
        bookmark = false;
      }
      else {
        bookmark =  true;
      }

    });
    return bookmark;

  }




  Future<void> addBookmark(article)async {

    article.dateBookmarked = DateTime.now();

    CollectionReference bookmarks = FirebaseFirestore.instance.collection('${article.type}')
        .doc('${article.title}').collection('Bookmarks');


    CollectionReference userBookmarks = FirebaseFirestore.instance.collection('Users')
        .doc('${userId}').collection('Bookmarks');

    bookmarks
        .doc('$userId')
        .set({
      'id':"${userId}"
    })
        .then((value)=> {
      //isbookmarked = true
      print("success")
    })
        .catchError((error) => print("Failed to add bookmark: $error"));

    userBookmarks
        .doc('${article.title}')
        .set({
      'content':"${article.content}",
      'image':"${article.image}",
      'title':"${article.title}",
      'type':"${article.type}"
    })
        .then((value)=> {

    })
        .catchError((error) => print("Failed to add bookmark: $error"));
  }

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

  void editList(article){
    CollectionReference bookmarks = FirebaseFirestore.instance.collection('${article.type}')
        .doc('${article.title}').collection('Bookmarks');

    bookmarks
        .where('id', isEqualTo: userId)
        .get()
        .then((QuerySnapshot snapshot){
      if(snapshot.docs.isEmpty){
        addBookmark(article);
      }
      else {
        removeBookmark(article);
      }
    });

  }

  void handlechange(article){
    setState(() {
      editList(article);
      isbookmarked = checkBookmark(article);

    });

      /*
      if(isbookmarked){
        isbookmarked = false;
      }
      else {
        isbookmarked = true;
      }
      editList(article);
    });*/
  }

  @override
  Widget build(BuildContext context) {


    return FutureBuilder<bool>(
        future: isbookmarked,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
          if(snapshot.hasData){
            bool bookmark = snapshot.data!;

            return IconButton(
                icon: bookmark? Icon(Icons.bookmark): Icon(Icons.bookmark_border),

                onPressed: (){
                  handlechange(widget.article);
                  print('${widget.article.title}...${isbookmarked}');
                }
                );
          }
          else if(snapshot.hasError){
            return Icon(Icons.error_outline);
          }
          else return Center(child: CircularProgressIndicator());

        }
    );


    /*return IconButton(
        icon: isbookmarked != null? Icon(Icons.bookmark): Icon(Icons.bookmark_border),

        onPressed: (){
          handlechange(widget.article);
          print('${widget.article.title}...${isbookmarked}');
        }

    );*/
  }

}