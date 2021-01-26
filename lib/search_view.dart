import 'package:flutter/material.dart';
import 'package:cardinal/Article-list-temp.dart';
import 'package:cardinal/Article-model.dart';

class SearchView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showSearch(context: context, delegate: DataSearch());
              }
          )
        ],
      ),
    );
  }
  
}

class DataSearch extends SearchDelegate<String>{
  @override
  List<Widget> buildActions(BuildContext context) {
    return[(
    IconButton(
      icon:Icon(Icons.clear),
      onPressed: (){
        query='';

        },
      )
    )];

  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);

      },
    );

  }

  @override
  Widget buildResults(BuildContext context) {
    RecentArticles.add(query);

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Suggestions(query: query);

  }
  
}

class Suggestions extends StatefulWidget{

  final query;

  Suggestions({this.query});

  @override
  SuggestionsState createState() => SuggestionsState();
}

class SuggestionsState extends State<Suggestions>{
  @override
  Widget build(BuildContext context) {
    final suggestionList= widget.query.isEmpty
        ? RecentArticles
        :TravelArticlesList.map((e) => e.title).toList().where((element) => element.contains(widget.query)).toList();


    final suggestions = TravelArticlesList
        .map((e) => e.title)
        .toList()
        .where((element) => element.contains(widget.query))
        .toList();

    return ListView.builder(
      itemBuilder: (context, index)=>ListTile(
        onTap: (){
        },

        leading: Icon(Icons.search),
        title: Text( suggestionList[index]
        ),
        trailing: IconButton(
          icon: Icon(Icons.highlight_remove),
          onPressed: (){
            setState(() {
              RecentArticles.remove(widget.query);
              print("removed");

            });


          },
        ),
      ),
      itemCount: suggestionList.length,
    );

  }

}
