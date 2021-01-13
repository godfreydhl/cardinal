import 'package:flutter/material.dart';
class TravelTab extends StatefulWidget {

  @override
  _TravelTabState createState() => _TravelTabState();
}

class _TravelTabState extends State<TravelTab> {
  get title => null;
  bool _isBookmarked = true;


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
                            image: AssetImage(imageSource),
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

    final List<String> titles =<String> ['Explore Egypt with a magnificent camel ride',
      '10 things to do in Capetown for a fun getaway',
      'What you may not know about Orlando Towers',
      'Bungee Jumping in Victoria falls. The experience of a lifetime',
      'Experience Swathi culture'];
    final List<String> images = <String> ['assets/images/travel1.jpg','assets/images/travel2.jpg','assets/images/travel3.jpg', 'assets/images/travel4.jpg', 'assets/images/travel5.jpg'];

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
