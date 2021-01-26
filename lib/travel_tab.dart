import 'package:flutter/material.dart';
import 'article-view.dart';
import 'Article-model.dart';
import 'Article-list-temp.dart';
class TravelTab extends StatefulWidget {

  @override
  _TravelTabState createState() => _TravelTabState();
}

class _TravelTabState extends State<TravelTab> {
  get title => null;
  bool _isBookmarked = true;


  Card _buildCard(Article article){
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
                        return ArticleView(article: article);
                      })
                      );
                    },
                    child: Container(
                      width:365,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(article.image),
                              colorFilter:
                              ColorFilter.mode(Colors.black.withOpacity(0.9999999),
                                  BlendMode.dstATop),
                              fit: BoxFit.fill
                          )
                      ),
                      child: Stack(
                        children: [
                          Opacity(
                            child:Container(
                              decoration: BoxDecoration(
                                  color: Colors.black
                              ),
                            ),
                            opacity: 0.7,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(article.title,
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,


                                ),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:<Widget> [
                  IconButton(
                    icon: Icon(Icons.share),
                    color: Colors.black,

                    onPressed:(){
                      debugPrint('share');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.bookmark_border),
                    color: Colors.black,

                    onPressed:(){
                      debugPrint('share');
                    },
                  ),

                ],
              )

            ],
          ),
        )
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: ListView.builder(
            padding:const EdgeInsets.all(8),
            itemCount: TravelArticlesList.length,
            itemBuilder: (BuildContext context, int index){
              return _buildCard(TravelArticlesList[index]);
            }
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
