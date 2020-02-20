import 'package:crud_kucing/constants/constants.dart';
import 'package:crud_kucing/models/kucing.dart';
import 'package:flutter/material.dart';

class KucingItemsListView extends StatelessWidget {
  const KucingItemsListView({
    Key key,
    @required this.context,
    @required this.index,
    @required List<Kucing> kucings,
  })  : _kucings = kucings,
        super(key: key);

  final BuildContext context;
  final int index;
  final List<Kucing> _kucings;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Center(
            child: ClipOval(
              child: Image(
                image: NetworkImage(
                  '${Constants.linkGambar}/${_kucings[index].gambar}',
                ),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                offset: Offset(1.0, 3.0),
                spreadRadius: 1.0,
              )
            ],
          ),
        ),
        SizedBox(width: 25),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _kucings[index].nama,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 11),
              Text(_kucings[index].jenis),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.star_border,
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
