import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'issue-detail-view.dart';
import 'issue-model.dart';

class Store extends StatefulWidget {


  @override
  _StoreState createState() => _StoreState();
}


class _StoreState extends State<Store> {

  Widget _buildBody(BuildContext context){
    return StreamBuilder <QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Issues').snapshots(),
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
    return Container(
      padding: const EdgeInsets.all(20),
      child: GridView.count(
        primary: false,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        crossAxisCount: 2,
        childAspectRatio: 0.645,
        padding: const EdgeInsets.only(top:20.0),
        children: snapshot.map((data) => _buildIssueCard(context, data)).toList(),
      ),
    );
  }



  Widget _buildIssueCard(BuildContext context, DocumentSnapshot data){
    final issue = Issue.fromSnapshot(data);

    Future<String> _url = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(issue.image)
        .getDownloadURL();
    return InkWell(

      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (_){
              return IssueDetail(issue: issue);
            })
        );
      },

      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          elevation: 8,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 3,
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
                                    )
                                ),

                            );
                          }
                          else if(snapshot.hasError){
                            return Icon(Icons.error_outline);
                          }
                          else return Center(child: CircularProgressIndicator(strokeWidth: 0.3,));

                        }
                    )
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                      issue.title
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left:8, right: 8, bottom: 8),
                  child: Text(
                      issue.price,
                      style: TextStyle(
                          color:Colors.green
                      )
                  ),
                ),


              ],
            ),
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            padding: const EdgeInsets.only(left:95),
            child: Text(
                'Store'
            ),
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: _buildBody(context)
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}