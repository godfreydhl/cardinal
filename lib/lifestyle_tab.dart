import 'package:flutter/material.dart';
class LifestyleTab extends StatefulWidget {

  @override
  _LifestyleTabState createState() => _LifestyleTabState();
}

class _LifestyleTabState extends State<LifestyleTab> {
  get title => null;


  Card _buildCard(String title, String imageSource){
    return Card(
        elevation: 8,
        child: Container(
          height: 250.0,
          width:370,
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    width:365,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            colorFilter:
                            ColorFilter.mode(Colors.black.withOpacity(0.9999999),
                                BlendMode.dstATop),
                            image: AssetImage(imageSource),
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
                            Text(title,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,

                              ),)
                          ],
                        ),
                      ],
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

    final List<String> titles =<String> ['Chef Dzulani and his fillet mignon with a twist',
      'Bad hair day? get the best hairstyling tips right here',
      'What\'s\ hot this season?',
      'Sculpt that V-Shaped body with these at home workouts',
      'Everything you need to know about taking care of your nails'];
    final List<String> images = <String> ['assets/images/food1.jpg','assets/images/model2.jpg','assets/images/fashion1.jpg', 'assets/images/model4.jpg', 'assets/images/nails.jpg'];

    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: ListView.builder(
            padding:const EdgeInsets.all(8),
            itemCount: titles.length,
            itemBuilder: (BuildContext context, int index){
              return _buildCard(titles[index], images[index]);
            }
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
