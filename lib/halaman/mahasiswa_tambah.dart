import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MahasiswaTambah extends StatefulWidget {
  const MahasiswaTambah({Key? key, required this.refresh}) : super(key: key);

  final Function refresh;
  MahasiswaTambahState createState() => MahasiswaTambahState();
}

class MahasiswaTambahState extends State<MahasiswaTambah> {
  final TextEditingController nim = TextEditingController();
  final TextEditingController nama = TextEditingController();
  final TextEditingController alamat = TextEditingController();
  bool sedangLoading = false;

  void simpan(BuildContext context) async {
    if (!sedangLoading) {
      setState(() {
        sedangLoading = true;
      });
      var url = Uri.http('192.168.18.59:3000', 'mahasiswa');
      var hasil = await http.post(
        url,
        headers: {"token": "123456", "Content-Type": "application/json"},
        body: convert.jsonEncode({
          "nim": nim.text,
          "nama": nama.text,
          "alamat": alamat.text,
        }),
      );
      var json = convert.jsonDecode(hasil.body);

      //tampilkan pesan
      String pesan = json['pesan'];
      var snackBar = SnackBar(
        content: Text(pesan),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      setState(() {
        sedangLoading = false;
      });

      widget.refresh();
      Navigator.pop(context);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text(
          'Tambah Mahasiswa',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Text("NIM"),
            TextFormField(
              controller: nim,
              decoration: InputDecoration(
                hintText: "Masukkan NIM",
              ),
            ),
            Text("Nama"),
            TextFormField(
              controller: nama,
              decoration: InputDecoration(
                hintText: "Masukkan Nama",
              ),
            ),
            Text("Alamat"),
            TextFormField(
              controller: alamat,
              decoration: InputDecoration(
                hintText: "Masukkan Alamat",
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: sedangLoading
                  ? CircularProgressIndicator()
                  : Icon(
                      Icons.save,
                      color: Colors.blue,
                    ),
              onPressed: () => simpan(context),
            )
          ],
        ),
      ),
    );
  }
}
