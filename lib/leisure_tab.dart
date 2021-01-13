import 'package:flutter/material.dart';
class LeisureTab extends StatefulWidget {

  @override
  _LeisureTabState createState() => _LeisureTabState();
}

class _LeisureTabState extends State<LeisureTab> {
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
                    child:Stack(
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

    final List<String> titles =<String> ['Wind down at Hwange Nationl Park Luxury Resort',
      'Top 10 restaurants to visit in Capetown',
      'A romantic getaway in the wine Region of Western Cape',
      'The new Durban Promenade and what to expect',
      'Rugby fans getting ready for a post Covid season'];
    final List<String> images = <String> ['assets/images/leisure.jpg','assets/images/leisure2.jpg','assets/images/leisure3.jpg', 'assets/images/leisure4.jpg', 'assets/images/leisure5.jpg'];

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
