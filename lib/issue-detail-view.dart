import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'preview-video-view.dart';
import 'issue-model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class IssueDetail extends StatelessWidget{

  IssueDetail({

    required this.issue});

  final Issue issue;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          FutureBuilder<String>(
            future: firebase_storage.FirebaseStorage.instance
              .ref()
              .child(issue.thumbnail)
              .getDownloadURL(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot){
              if(snapshot.hasData){
                return Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(snapshot.data.toString()),
                          fit: BoxFit.fill
                      )
                  ),
                  child: IconButton(
                    icon:Icon(Icons.play_circle_fill_sharp),
                    iconSize: 70,
                    color: Colors.white,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (_){
                            return VideoPlayerScreen(issue: issue);
                          })
                      );
                    },
                  ),
                );

              }
              else if(snapshot.hasError){
                return Icon(Icons.error_outline);
              }
              else return Container(
                  height: 200,
                  width: 200,
                child: Center(
                      child: CircularProgressIndicator(strokeWidth: 0.3,)
                  ),
              );
              },
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  child: FutureBuilder<String>(
                    future: firebase_storage.FirebaseStorage.instance
                        .ref()
                        .child(issue.image)
                        .getDownloadURL(),
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                      if(snapshot.hasData){
                        return Container(
                          height: 180,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:NetworkImage(snapshot.data.toString()),
                                fit: BoxFit.fill
                            ),
                          ),
                        );

                      }
                      else if(snapshot.hasError){
                        return Icon(Icons.error_outline);
                      }
                      else return Container(
                            height: 180,
                            width: 120,
                            child: Center(
                                child: CircularProgressIndicator(strokeWidth: 0.3,)
                            )
                        );

                    }

                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left:16, bottom: 8, top:0),
                        child: Text(issue.title,
                          style: TextStyle(
                            fontSize: 30,
                          fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left:16, bottom: 8),
                        child: Text(issue.date,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left:16, bottom: 8),
                        child: Text(issue.price,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.green
                          ),
                        ),
                      ),


                      Container(
                        padding: const EdgeInsets.only(left:16, top: 8),
                        child: ElevatedButton(
                            onPressed: null,/*() {Navigator.push(context, MaterialPageRoute(
                                builder: (_){
                                  return PdfView(issue: issue);
                                })
                              );
                            },*/
                            child: Text(
                              '  BUY NOW  ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                            ),

                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'About this issue',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),

            child: Text(issue.about,
              style: TextStyle(
                fontSize: 20
              ),
            ),
          )

        ],
      )
    );
  }

}