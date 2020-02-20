import 'package:crud_kucing/models/kucing.dart';
import 'package:crud_kucing/ui/widgets/post_list_grid.dart';
import 'package:flutter/material.dart';

class PostTab extends StatefulWidget {
  @override
  _PostTabState createState() => _PostTabState();
}

//* kombinasi AutomaticKeepAliveClientMixin dan runOnce
// agar tabPost tidak rebuild ketika diganti

class _PostTabState extends State<PostTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: double.infinity,
      ),
      child: FutureBuilder(
        future: Kucing.getKucings(),
        builder: (context, snapshost) {
          switch (snapshost.connectionState) {
            case ConnectionState.none:
              return Text('Try again');
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshost.hasError) return Text(snapshost.error.toString());
              return PostGrid(kucings: snapshost.data);
          }
        },
      ),
    );
  }
}
