import 'dart:math';

import 'package:crud_kucing/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:crud_kucing/models/kucing.dart';

class KucingPostItem extends StatelessWidget {
  final BuildContext context;
  final int index;
  final List<Kucing> kucings;

  KucingPostItem({Key key, this.context, this.index, this.kucings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(backgroundImage: AssetImage('images/picture_3.jpg')),
              SizedBox(width: 10),
              Text('Jane Doe'),
              Spacer(),
              Icon(Icons.more_horiz, color: Colors.blueGrey.shade300),
            ],
          ),
          SizedBox(height: 6),
          Hero(
            tag: 'image${kucings[index].id}',
            child: Container(
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage('${Constants.linkGambar}/${kucings[index].gambar}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Icon(Icons.favorite, color: Colors.blueGrey.shade300),
              Text(Random().nextInt(1000).toString()),
              SizedBox(width: 5),
              Icon(Icons.comment, color: Colors.blueGrey.shade300),
              Text(Random().nextInt(300).toString()),
              SizedBox(width: 5),
              Spacer(),
              Icon(Icons.share, color: Colors.blueGrey.shade300),
            ],
          )
        ],
      ),
    );
  }
}
