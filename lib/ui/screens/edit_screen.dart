import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crud_kucing/constants/constants.dart';
import 'package:crud_kucing/models/kucing.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:image/image.dart' as Img;
import 'package:path_provider/path_provider.dart';

class EditScreen extends StatefulWidget {
  EditScreen({var this.id});
  final id;

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  File _image;
  bool isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController cNama = TextEditingController();
  TextEditingController cJenis = TextEditingController();
  TextEditingController cUmur = TextEditingController();
  TextEditingController cHarga = TextEditingController();

  // mendapat data kucing
  Kucing kucing = Kucing();

  @override
  void initState() {
    super.initState();
    _populateKucing();
  }

  void _populateKucing() {
    Kucing.getKucing(widget.id).then((data) {
      setState(() {
        kucing = data;
        cNama.text = kucing.nama;
        cJenis.text = kucing.jenis;
        cUmur.text = kucing.umur.toString();
      });
    });
  }

  Future getImageGallery() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = imageFile;
    });
  }

  Future getImageCamera() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = imageFile;
    });
  }

  Future upload(File imageFile, BuildContext context) async {
    String nama = cNama.text;

    if (nama.trim().isEmpty) {
      _displaySnackBar(context: context, text: 'Please complete the form !!');
      return;
    }

    setState(() {
      isLoading = true;
    });

    var uri = Uri.parse(Constants.linkApi + '/' + kucing.id.toString());
    var request = http.MultipartRequest("POST", uri);

    //* Mengatur kondisi jika mengisi file maka akan di proses
    //* dan menggunakan argument gambar
    if (imageFile != null) {
      //* Compressing Image

      // mengambil directori sementara untuk pproses pengecilan gambar
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;

      Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
      Img.Image smallerImg = Img.copyResize(image, height: 800);

      // .. cascade operator = for chaining the first method
      var compressedImg = File("$path/image_$nama.jpg")
        ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 90));

      //* Upload Process
      var stream = http.ByteStream(DelegatingStream.typed(compressedImg.openRead()));
      var length = await compressedImg.length();

      var multipartFile =
          http.MultipartFile('gambar', stream, length, filename: basename(compressedImg.path));
      request.files.add(multipartFile);
    }

    //* Jika tidak memasukkan gambar maka akan menggunakan
    //* gambar lama yg di masukkan ke query gambar_lama
    //* logika ini sudah di proses di Backend Laravel

    // masukan field sama dengan key pada api
    request.fields['nama'] = cNama.text;
    request.fields['jenis'] = cJenis.text;
    request.fields['umur'] = cUmur.text;
    request.fields['gambar_lama'] = kucing.gambar;
    // request.fields['_method'] = 'put';

    var response = await request.send();

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      print('Cat Updated');
      _displaySnackBar(context: context, text: 'Cat Updated');
      Future.delayed(Duration(milliseconds: 400), () {
        Navigator.of(context).pop(true);
      });
    } else {
      _displaySnackBar(context: context, text: 'Update Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: kucing.nama != null
              ? Column(
                  children: <Widget>[
                    Center(
                      child: _image == null
                          ? CachedNetworkImage(
                              imageUrl: Constants.linkGambar + '/' + kucing.gambar,
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            )
                          : Container(
                              constraints: BoxConstraints(maxHeight: 350),
                              child: Image.file(
                                _image,
                              ),
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          child: Icon(Icons.image),
                          onPressed: getImageGallery,
                        ),
                        RaisedButton(
                          child: Icon(Icons.camera_alt),
                          onPressed: getImageCamera,
                        ),
                      ],
                    ),
                    TextField(
                      controller: cNama,
                      decoration: InputDecoration(hintText: "Nama"),
                    ),
                    TextField(
                      controller: cJenis,
                      decoration: InputDecoration(hintText: "Jenis"),
                    ),
                    TextField(
                      controller: cUmur,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "Umur"),
                    ),
                    RaisedButton(
                      child: Text('Submit'),
                      color: Colors.lightBlueAccent,
                      textColor: Colors.white,
                      onPressed: () {
                        upload(_image, context);
                      },
                    )
                  ],
                )
              : Center(child: Text('Loading . . .')),
        ),
      ),
    );
  }

  _displaySnackBar({BuildContext context, String text}) {
    final snackbar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.blueAccent,
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
