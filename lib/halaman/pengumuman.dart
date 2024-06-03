import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'pengumuman_detail.dart';
import 'dart:convert' as convert;

class Pengumuman extends StatefulWidget {
  PengumumanState createState() => PengumumanState();
}

class PengumumanState extends State<Pengumuman> {
  late Future<List> responseInfo;

  @override
  void initState() {
    responseInfo = getInfo();
    super.initState();
  }

  Future<List<dynamic>> getInfo() async {
    var url = Uri.http('192.168.18.59:3000', 'pengumuman');
    var hasil = await http.get(
      url,
      headers: {"token": "123456"},
    );
    var json = convert.jsonDecode(hasil.body);
    return json['data'];
  }

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
                  child: Container(
                    padding:
                        EdgeInsets.all(20.0), // Adjust the padding for the card
                    child: Column(
                      children: [
                        Text(
                          snapshot.data[index]['namapengumuman'] ??
                              'Judul Tidak Tersedia',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () async => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PengumumanDetail(
                        namapengumuman: snapshot.data[index]
                                ['namapengumuman'] ??
                            'judul tidak tersedia',
                        isipengumuman: snapshot.data[index]['isipengumuman'] ??
                            'Deskripsi Tidak Tersedia',
                      ),
                    ),
                  ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        title: Text(
          'Pengumuman',
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
