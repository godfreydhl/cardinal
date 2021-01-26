import 'package:flutter/material.dart';
import 'Article-model.dart';


class ArticlePage extends StatelessWidget{

  ArticlePage({
    this.article
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
           IconButton(
             icon: Icon(Icons.bookmark_border),
             color: Colors.white,

             onPressed:(){
               debugPrint('bookmark');
             },
           ),
         ],
      ),
      body: Container(
              padding: const EdgeInsets.all(8),

              child: ListView(
                children: [
                  Container(
                    height: 250.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(article.image),
                        fit: BoxFit.fill
                      ),
                    ),
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
                  )
                ],
              )
            )
    );


  }
  
}