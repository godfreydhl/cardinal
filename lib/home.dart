import 'package:flutter/material.dart';
import 'leisure_tab.dart';
import 'travel_tab.dart';
import 'search_view.dart';


import 'lifestyle_tab.dart';



class TabbedPage extends StatefulWidget {

  @override
  _TabbedPageState createState() => _TabbedPageState();
}

class _TabbedPageState extends State<TabbedPage> with SingleTickerProviderStateMixin {

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Travel'),
    Tab(text: 'Leisure'),
    Tab(text: 'Lifestyle')


  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Image.asset('assets/images/logo.jpg'),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                  showSearch(context: context, delegate: DataSearch());
                })
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
            controller: _tabController,
            children: [
              TravelTab(),
              LeisureTab(),
              LifestyleTab()
            ]
        )
    );
  }
}
