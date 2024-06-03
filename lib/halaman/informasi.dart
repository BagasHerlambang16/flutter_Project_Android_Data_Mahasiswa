import 'package:flutter/material.dart';
import 'informasi_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Informasi extends StatefulWidget {
  InformasiState createState() => InformasiState();
}

class InformasiState extends State<Informasi> {
  Widget widgetInfo() {
    return FutureBuilder(
      future: responseInfo,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Card(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    children: [
                      Image.network(
                        snapshot.data[index]['gambar'],
                        width: double.infinity, // Mengisi lebar gambar
                        height: 200.0, // Mengisi tinggi gambar
                        fit: BoxFit.cover, // Menyesuaikan gambar
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data[index]['judul'],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () async => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InformasiDetail(
                        judul: snapshot.data[index]['judul'],
                        konten: snapshot.data[index]['konten'],
                        gambar: snapshot.data[index]['gambar'],
                      ),
                    ),
                  )
                },
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  late Future<List> responseInfo;

  Future<List<dynamic>> getInfo() async {
    var url = Uri.http('192.168.18.59:3000', 'informasi');
    var hasil = await http.get(
      url,
      headers: {"token": "123456"},
    );
    var json = convert.jsonDecode(hasil.body);
    return json['data'];
  }

  @override
  void initState() {
    responseInfo = getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informasi',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: widgetInfo(),
      ),
    );
  }
}
