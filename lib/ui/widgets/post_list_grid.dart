import 'dart:math';
import 'package:crud_kucing/constants/constants.dart';
import 'package:crud_kucing/models/kucing.dart';
import 'package:crud_kucing/ui/screens/detail_screen.dart';
import 'package:crud_kucing/utils/intsize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PostGrid extends StatelessWidget {
  // : initializer list
  PostGrid({this.kucings}) : _sizes = _createSizes(kucings.length).toList();

  final List<Kucing> kucings;
  final List<IntSize> _sizes;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StaggeredGridView.countBuilder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(top: 2.0),
        mainAxisSpacing: 15,
        crossAxisSpacing: 10,
        crossAxisCount: 4,
        itemCount: kucings.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              int id = kucings[index].id;
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DetailScreen(id: id)));
            },
            child: Container(
              width: _sizes[index].width.toDouble(),
              height: _sizes[index].height.toDouble(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage('${Constants.linkGambar}/${kucings[index].gambar}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      ),
    );
  }
}

List<IntSize> _createSizes(int count) {
  Random rnd = new Random();
  return new List.generate(
      count, (i) => new IntSize((rnd.nextInt(100) + 150), rnd.nextInt(100) + 150));
}
