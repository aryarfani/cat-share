import 'dart:convert';
import 'package:crud_kucing/constants/constants.dart';
import 'package:http/http.dart' as http;

class Kucing {
  final int id;
  final String nama;
  final String jenis;
  final int umur;
  final String harga;
  final String gambar;

  Kucing({this.id, this.nama, this.jenis, this.umur, this.harga, this.gambar});

  factory Kucing.createKucing(Map<String, dynamic> json) {
    return Kucing(
      id: json['id'],
      nama: json['nama'],
      jenis: json['jenis'],
      umur: json['umur'],
      gambar: json['gambar'],
    );
  }

  static Future<List<Kucing>> getKucings() async {
    var res = await http.get(Constants.linkApi);
    var jsonObject = await json.decode(res.body);
    print(jsonObject);
    // List<dynamic> listKucing = (jsonObject as Map<String, dynamic>)['data'];
    List<dynamic> listKucing = jsonObject;
    List<Kucing> kucings = [];
    for (int i = 0; i < listKucing.length; i++) {
      kucings.add(Kucing.createKucing(listKucing[i]));
    }

    print('getKucings done');
    return kucings;
  }

  static Future<Kucing> getKucing(var id) async {
    var res = await http.get(Constants.linkApi + '/$id');
    print(Constants.linkApi + '/$id');
    var jsonObject = await json.decode(res.body);

    print('getKucing done');
    return Kucing.createKucing(jsonObject);
  }

  static deleteKucing(var id) async {
    print('deletkucing is working');
    // var res = await http.delete(Constants.linkApi + '/$id');
    var uri = Uri.parse(Constants.linkApi + '/$id');
    var request = http.MultipartRequest('POST', uri);
    request.fields['_method'] = 'delete';

    var res = await request.send();

    print('deleteKucing $id done');
    if (res.statusCode == 200) {
      return true;
    }

    return false;
  }
}
