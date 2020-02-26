import 'dart:io';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:crud_kucing/constants/constants.dart';
import 'package:crud_kucing/ui/screens/home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:image/image.dart' as Img;
import 'package:path_provider/path_provider.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  static String routeName = 'add';
  File _image;
  bool isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController cNama = TextEditingController();
  TextEditingController cJenis = TextEditingController();
  TextEditingController cUmur = TextEditingController();

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stop) {
    print('intercepted');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  insertedIndex: 0,
                )));
    return true;
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

  void _clearForm() {
    cNama.text = '';
    cJenis.text = '';
    cUmur.text = '';
    _image = null;
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
    var uri = Uri.parse(Constants.linkApi);

    var request = http.MultipartRequest("POST", uri);
    var multipartFile =
        http.MultipartFile('gambar', stream, length, filename: Path.basename(compressedImg.path));

    // masukan field sama dengan key pada api
    request.fields['nama'] = cNama.text;
    request.fields['jenis'] = cJenis.text;
    request.fields['umur'] = cUmur.text;
    request.files.add(multipartFile);

    var response = await request.send();

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 201) {
      print('Image Uploaded');
      _displaySnackBar(context: context, text: 'Image Uploaded');
      _clearForm();
    } else {
      _displaySnackBar(context: context, text: 'Upload Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: _image == null
                      ? InkWell(
                          onTap: () {
                            showDialog<String>(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.camera),
                                        title: Text('Pick from camera'),
                                        onTap: () => getImageCamera(),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.insert_photo),
                                        title: Text('Pick from gallery'),
                                        onTap: () => getImageGallery(),
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            height: 300,
                            child: Center(child: Icon(Icons.add_a_photo, size: 50)),
                          ),
                        )
                      : Container(
                          constraints: BoxConstraints(maxHeight: 350),
                          child: Image.file(
                            _image,
                          ),
                        ),
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
                SizedBox(height: 10),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: Colors.blueAccent),
                  ),
                  child: Text('Post'),
                  color: Colors.lightBlueAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    upload(_image, context);
                  },
                )
              ],
            ),
          ),
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
