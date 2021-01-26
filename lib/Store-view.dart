import 'package:flutter/material.dart';
import 'issue-detail-view.dart';
import 'issue-model.dart';
import 'issue-list-temp.dart';

class Store extends StatefulWidget {

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store>{

  Widget _buildIssueCard(BuildContext context, Issue issue){
    return  InkWell(
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
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(issue.image),
                            fit: BoxFit.fill
                        )
                    )
                ),
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
                        color:Colors.grey[500]
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

      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          primary: false,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          crossAxisCount: 2,
          childAspectRatio: 0.645,

          children:<Widget> [
            _buildIssueCard(context, Issues[0]),
            _buildIssueCard(context,Issues[1]),
            _buildIssueCard(context, Issues[2]),
            _buildIssueCard(context,Issues[3]),


          ],
        ),
      )
    );
  }

}