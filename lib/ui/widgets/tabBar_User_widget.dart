import 'package:crud_kucing/ui/widgets/post_tab_widget.dart';
import 'package:flutter/material.dart';

class TabBarUser extends StatefulWidget {
  @override
  _TabBarUserState createState() => _TabBarUserState();
}

class _TabBarUserState extends State<TabBarUser> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabTitleList.length);
  }

  TabController _tabController;

  List<Tab> _tabChildrenList = [
    Tab(child: PostTab()),
    Tab(child: Text('Loved')),
  ];

  List<Tab> _tabTitleList = [
    Tab(child: Text('Posts')),
    Tab(child: Text('Loved')),
  ];

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 35,
          child: TabBar(
            labelColor: Colors.black87,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.black45,
            controller: _tabController,
            tabs: _tabTitleList,
          ),
        ),
        Container(
          height: 300,
          child: TabBarView(
            controller: _tabController,
            children: _tabChildrenList,
          ),
        ),
      ],
    );
  }
}
