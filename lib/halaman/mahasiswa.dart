import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'mahasiswa_detail.dart';
import 'mahasiswa_tambah.dart';

class Mahasiswa extends StatefulWidget {
  MahasiswaState createState() => MahasiswaState();
}

class MahasiswaState extends State<Mahasiswa> {
//membuat variabel untuk response info
  late Future<List> responseInfo;
//info terbaru dari API
  Future<List<dynamic>> getMahasiswa() async {
    var url = Uri.http('192.168.18.59:3000', 'mahasiswa');
    var hasil = await http.get(
      url,
      headers: {"token": "123456"},
    );
    var json = convert.jsonDecode(hasil.body);
    return json['data'];
  }

//memanggil future/fungsi getMahasiswa
//saat inisialisasi awal
  @override
  void initState() {
    super.initState();
    responseInfo = getMahasiswa();
  }

  void refreshData() {
    setState(() {
      responseInfo = getMahasiswa();
    });
  }

  Widget widgetInfo() {
    return FutureBuilder(
      future: responseInfo,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return snapshot.data.length == 0
              ? Center(child: Text("Data Kosong"))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Card(
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: ListTile(
                          title: Text(snapshot.data[index]['nama'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Text(
                              "NIM: ${snapshot.data[index]['nim']}  Alamat: ${snapshot.data[index]['alamat']}"),
                        ),
                      ),
                      onTap: () async => {
                        //disini nanti memanggil detail mahasiswa
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MahasiswaDetail(
                              nim: snapshot.data[index]['nim'],
                              nama: snapshot.data[index]['nama'],
                              alamat: snapshot.data[index]['alamat'],
                              refresh: refreshData,
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mahasiswa',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: Container(
        width: 150.0, // Set the width to adjust the size
        height: 50.0, // Set the height to adjust the size
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Text(
            "Tambah Mahasiswa",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MahasiswaTambah(refresh: refreshData),
              ),
            );
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: widgetInfo(),
      ),
    );
  }
}
