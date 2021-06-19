import 'package:flutter/material.dart';
import 'Article.dart';
import 'BookmarkIcon.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class ArticleView extends StatelessWidget{

  ArticleView({
    required this.article
  });

  final Article article;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,

          onPressed:(){
            Navigator.pop(context);
          },
        ),
         actions: [
           IconButton(
             icon: Icon(Icons.share),
             color: Colors.white,

             onPressed:(){
               debugPrint('share');
             },
           ),
           BookmarkIcon(article: article),

         ],
      ),
      body: Container(
              padding: const EdgeInsets.all(8),

              child: ListView(
                children: [
                  FutureBuilder<String>(
                      future: firebase_storage.FirebaseStorage.instance
                          .ref()
                          .child(article.image)
                          .getDownloadURL(),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                        if(snapshot.hasData){
                          return Container(
                            height: 250.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(snapshot.data.toString()),
                                  fit: BoxFit.fill
                              ),
                            ),
                          );
                        }
                        else if(snapshot.hasError){
                          print(snapshot.error);
                          return Icon(Icons.error_outline);
                        }
                        else return Container(
                              height:250.0,
                              child: Center(
                                  child: CircularProgressIndicator(strokeWidth: 0.3)
                              )
                          );

                      }
                  ),


                  Container(
                    padding: const EdgeInsets.only(bottom:8, left: 8, top: 8),
                    child: Text(
                      article.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom:8, left: 8),
                    child: Text(
                      'Updated Jan 20, 2021',
                      style: TextStyle(
                        color:Colors.grey[500],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      article.content,
                      style: TextStyle(
                        fontSize: 20,
                      )
                    ),
                  ),

                ],
              )
            )
    );


  }
  
}