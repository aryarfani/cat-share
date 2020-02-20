import 'package:crud_kucing/ui/widgets/post_tab_widget.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  List<Tab> _tabChildrenList = [
    Tab(child: PostTab()),
    Tab(child: Text('Loved')),
  ];

  List<Tab> _tabTitleList = [
    Tab(child: Text('Posts')),
    Tab(child: Text('Loved')),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                expandedHeight: 374,
                pinned: false,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'aryarfani\'s profile',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(Icons.menu)
                          ],
                        ),
                      ),
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(maxWidth: 200),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                                offset: Offset(1.0, 1.0),
                                spreadRadius: 1.0,
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(180.0),
                            child: Image.asset('images/picture_3.jpg'),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Center(
                        child: Text(
                          'Jane Doe',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                '283',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 3.0),
                              Text(
                                'Posts',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                '121',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 3.0),
                              Text(
                                'Lovers',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                '143',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 3.0),
                              Text(
                                'Loving',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: 20,
                        thickness: 1.0,
                      ),
                    ],
                  ),
                ),
                bottom: TabBar(
                  labelColor: Colors.black87,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.black45,
                  controller: _tabController,
                  tabs: _tabTitleList,
                ),
              )
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: _tabChildrenList,
          ),
        ),
      ),
    );
  }
}
