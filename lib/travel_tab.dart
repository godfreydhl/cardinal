import 'package:cardinal/article-view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'Article.dart';
import 'BookmarkIcon.dart';
class TravelTab extends StatefulWidget {
  
  
  @override
  _TravelTabState createState() => _TravelTabState();
}


class _TravelTabState extends State<TravelTab> {

  Widget _buildBody(BuildContext context){
    return StreamBuilder <QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Travel_Articles').snapshots(),
      builder: (context, snapshot){

        if (snapshot.hasError) {
          return Center(
              child: Text('Something went wrong')
          );
        }

        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return _buildList(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot){
    return ListView(
      padding: const EdgeInsets.only(top:20.0),
      children: snapshot.map((data) => _buildCard(context, data)).toList(),
    );
  }

  Widget _buildButtonRow(Article article){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children:<Widget> [
        IconButton(
          icon: Icon(Icons.share),

          onPressed:(){
            debugPrint('share');
          },
        ),
        BookmarkIcon(article: article)

      ],
    );
  }




  Widget _buildCard(BuildContext context, DocumentSnapshot data){
    final article = Article.fromSnapshot(data);

    Future<String> _url = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(article.image)
        .getDownloadURL();
    return Card(
        elevation: 8,
        child: Container(
          height: 250.0,
          width:370,
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (_){
                            return(ArticleView(article: article));
                      })
                      );
                    },
                    child: FutureBuilder<String>(
                        future: _url,
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                          if(snapshot.hasData){
                            return Container(
                              width:365,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(snapshot.data.toString()
                                      ),
                                      fit: BoxFit.fill,
                                      colorFilter:
                                      ColorFilter.mode(Colors.black.withOpacity(0.999999),
                                        BlendMode.dstATop),
                                  )
                              ),
                              child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(article.title,
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,

                                      ),
                                    )
                                  ],
                                )
                            );
                          }
                          else if(snapshot.hasError){
                            return Icon(Icons.error_outline);
                          }
                          else return Center(child: CircularProgressIndicator(strokeWidth: 0.3,));

                        }
                    ),
                  )
              ),
              _buildButtonRow(article)

            ],
          ),
        )
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