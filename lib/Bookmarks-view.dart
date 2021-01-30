import 'package:flutter/material.dart';
import 'package:cardinal/Article-model.dart';
import 'package:cardinal/Article-list-temp.dart';

class Bookmarks extends StatefulWidget {
  _BookmarksState createState() => _BookmarksState();

}

class _BookmarksState extends State<Bookmarks>{

  InkWell _buildBookmark(Article article){
    return InkWell(
      child: Card(
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(article.image)
                )

            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top:8, left: 8),
                    child: Text(
                      article.title
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top:8, left: 8),
                    child: Text(
                      'Today'
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                     mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){
                          article.isBookmarked = false;
                        }
                      ),
                      IconButton(
                          icon: Icon(Icons.share),
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

        ),
        backgroundColor: Colors.grey[200],
        body: ListView.builder(
            padding:const EdgeInsets.all(8),
            itemCount: bookmarks.length,
            itemBuilder: (BuildContext context, int index){
              return _buildBookmark(bookmarks[index]);
            },

        ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}