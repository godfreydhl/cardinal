import 'package:flutter/material.dart';
import 'package:cardinal/Article-list-temp.dart';
import 'package:cardinal/Article-model.dart';
import 'article-view.dart';
import 'main.dart';
class SearchView extends StatefulWidget{


  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) => showSearch(context: context, delegate: DataSearch()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
    );
  }


}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [(
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        )
    )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.arrow_menu,
        progress: transitionAnimation,

      ),
      onPressed: (){

      },

    );

  }

  @override
  Widget buildResults(BuildContext context) {
    if (!RecentArticles.contains(query)) {
      RecentArticles.insert(0, query);
    }

    final results = TravelArticlesList
        .where((element) => element.title.contains(query))
        .toList();

    return ListView.builder(itemBuilder: (context, index) =>
        ListTile(
          title: Text(results[index].title),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (_) {
                  return ArticleView(article: results[index]);
                })
            );
          },
          leading: Icon(Icons.article),
        ),
      itemCount: results.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = TravelArticlesList
        .map((e) => e.title)
        .toList()
        .where((element) => element.contains(query))
        .toList();

    final suggestionList = query.isEmpty
        ? RecentArticles
        : suggestions;
    return ListView.builder(
        itemBuilder: (context, index) =>
            ListTile(
              onTap: () {
                query = suggestionList[index];

                if (!RecentArticles.contains(query)) {
                  RecentArticles.insert(0, query);
                }

                showResults(context);
              },

              leading: query.isEmpty
                  ? Icon(Icons.history)
                  : Icon(Icons.search),
              title: Text(suggestionList[index]
              ),
            ),
        itemCount: suggestionList.length
    );
  }
}