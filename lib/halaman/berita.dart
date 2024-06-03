import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BeritaPage extends StatefulWidget {
  const BeritaPage({Key? key}) : super(key: key);

  @override
  _BeritaPageState createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  late Future<List<dynamic>> _infoData;

  @override
  void initState() {
    _infoData = getInfo();
    super.initState();
  }

  Future<List<dynamic>> getInfo() async {
    var url = Uri.https('udb.ac.id', 'json/info-akademik');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Berita',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _infoData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data[index]['gambar']),
                    ),
                    title: Text(
                      snapshot.data[index]['judul'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(snapshot.data[index]['tanggal']),
                    trailing: IconButton(
                      onPressed: () async {},
                      icon: const Icon(Icons.link),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
