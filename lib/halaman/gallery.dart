import 'package:flutter/material.dart';
import 'gallery_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Gallery extends StatefulWidget {
  GalleryState createState() => GalleryState();
}

class GalleryState extends State<Gallery> {
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
                  child: Row(
                    children: [
                      // Gambar
                      Container(
                        width: 100.0, // Mengurangi lebar gambar
                        height: 100.0, // Mengurangi tinggi gambar
                        child: Image.network(
                          snapshot.data[index]['gambar'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10.0), // Spasi antara gambar dan teks
                      // Nama
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Teks diatur ke atas
                          children: [
                            Text(
                              snapshot.data[index]['nama'],
                              style: TextStyle(
                                fontSize: 16.0, // Mengurangi ukuran teks
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Tambahkan spasi di bawah teks jika diperlukan
                            SizedBox(height: 5.0),
                            // Tambahkan deskripsi jika ada
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () async => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GalleryDetail(
                        nama: snapshot.data[index]['nama'],
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
    var url = Uri.http('192.168.18.59:3000', 'gallery');
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
          'Gallery',
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
