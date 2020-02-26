import 'package:crud_kucing/models/kucing.dart';
import 'package:crud_kucing/ui/screens/detail_screen.dart';
import 'package:crud_kucing/ui/widgets/kucing_list_item_widget.dart';
import 'package:flutter/material.dart';

class KucingList extends StatefulWidget {
  @override
  _KucingListState createState() => _KucingListState();
}

class _KucingListState extends State<KucingList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    if (this.mounted) {
      _populateKucings();
    }
  }

  List<Kucing> _kucings = List<Kucing>();
  void _populateKucings() {
    Kucing.getKucings().then((kucing) {
      if (this.mounted) {
        setState(() {
          _kucings = kucing;
        });
      }
    });
  }

  Future<String> _refreshKucings() async {
    _populateKucings();
    _displaySnackBar('Kucing list refreshed');
    return 'success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          'Purr Lovers',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refreshKucings,
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(10, 10, 5, 0),
            shrinkWrap: true,
            itemCount: _kucings.length == null ? 0 : _kucings.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: KucingPostItem(
                  context: context,
                  index: index,
                  kucings: _kucings,
                ),
                onTap: () async {
                  int id = _kucings[index].id;
                  // mengambil tindakan jika di hapus dengan kembalian paramater true
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailScreen(id: id)),
                  );

                  if (result != null) {
                    // memprosess dengan mentrigger refresh indicator
                    _refreshIndicatorKey.currentState.show();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  _displaySnackBar(String text) {
    final snackbar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.blueAccent,
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
