import 'package:flutter/material.dart';
import 'package:cardinal/Article-model.dart';
import 'package:cardinal/Article-list-temp.dart';
import 'article-view.dart';
import 'package:date_format/date_format.dart';


class Bookmarks extends StatefulWidget {
  _BookmarksState createState() => _BookmarksState();

}

class _BookmarksState extends State<Bookmarks>{

  InkWell _buildBookmark(Article article){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (_){
              return ArticleView(article: article);
            })
        );
      },
      child: Card(
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  child: Image.asset(article.image),
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
                    child: Text('Saved on ${formatDate(article.dateBookmarked, [dd, ' ', M, ' ', yyyy])}'
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
                            article.isBookmarked = false;
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
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final bookmarks = TravelArticlesList
        .where((element) => element.isBookmarked)
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: Container(
            padding: const EdgeInsets.only(left:70),
            child: Text(
              'Saved Articles'
            ),
          ),

        ),
        backgroundColor: Colors.grey[200],
        body:(bookmarks.isEmpty)
            ?Center(
          child: Text('No saved articles',
            style: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
                fontSize: 24
            ),
          ),
        )
            : ListView.builder(
            padding:const EdgeInsets.all(8),
            itemCount: bookmarks.length,
            itemBuilder: (BuildContext context, int index){
              return _buildBookmark(bookmarks[index]);
            },

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
              bookmarks.forEach((element) {element.isBookmarked=false;});
            });

          },
          backgroundColor: Colors.red,
          child: Icon(Icons.delete, color: Colors.white,),
        ),


      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}