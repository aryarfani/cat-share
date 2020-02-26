import 'package:crud_kucing/constants/constants.dart';
import 'package:crud_kucing/ui/screens/edit_screen.dart';
import 'package:crud_kucing/ui/widgets/dialog.dart';
import 'package:crud_kucing/ui/widgets/zoom_photo.dart';
import 'package:flutter/material.dart';
import 'package:crud_kucing/models/kucing.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({var this.id});
  final id;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Kucing kucing = Kucing();

  @override
  void initState() {
    super.initState();
    _populateKucing();
  }

  void _populateKucing() {
    Kucing.getKucing(widget.id).then((data) {
      if (mounted) {
        setState(() {
          kucing = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.blueAccent),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showAlertDialog(context, () async {
                print(await Kucing.deleteKucing(kucing.id));
              });
            },
          ),
        ],
      ),
      body: kucing.nama != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ZoomPhoto(
                                imageProvider:
                                    NetworkImage(Constants.linkGambar + '/' + kucing.gambar))));
                  },
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 320),
                    child: Hero(
                      tag: 'gambar',
                      child: Image.network(Constants.linkGambar + '/' + kucing.gambar),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFFE7F3FF), Colors.lightBlue[50]],
                          begin: FractionalOffset(0, 0),
                          end: FractionalOffset(0, 1),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0, bottom: 5.0),
                          child: Text(
                            kucing.nama,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[Icon(Icons.location_on), Text('Kediri, Jawa Timur')],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Lokasi',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Kediri',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'Umur',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  kucing.umur.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'Jenis',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  kucing.jenis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(3.0, 18, 0, 10),
                          child: Text(
                            'Deskripsi',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, bottom: 5.0),
                          child: Text(
                            'Cat is not just merely an animal, it\'s our bestfriend, no matter what you\'ve been through in your life, just remember that there is a majestic creature that will tell you what  the meaning of life is. ',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            RaisedButton(
                                elevation: 0.4,
                                color: Colors.blueAccent,
                                child: Text(
                                  'Update This Cat',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  var _cekIfUpdated = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditScreen(id: kucing.id)));
                                  if (_cekIfUpdated != null) {
                                    Navigator.of(context).pop(true);
                                  }
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Center(child: Text('Loading . . .')),
    );
  }
}
