import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MahasiswaDetail extends StatefulWidget {
  const MahasiswaDetail({
    Key? key,
    required this.nim,
    required this.nama,
    required this.alamat,
    required this.refresh,
  }) : super(key: key);

  final String nim;
  final String nama;
  final String alamat;
  final Function refresh;
  MahasiswaDetailState createState() => MahasiswaDetailState();
}

class MahasiswaDetailState extends State<MahasiswaDetail> {
  final TextEditingController nim = TextEditingController();
  final TextEditingController nama = TextEditingController();
  final TextEditingController alamat = TextEditingController();
  bool sedangLoading = false;

  @override
  void initState() {
    super.initState();
    nim.text = widget.nim;
    nama.text = widget.nama;
    alamat.text = widget.alamat;
  }

  void ubah(BuildContext context) async {
    if (!sedangLoading) {
      setState(() {
        sedangLoading = true;
      });

      var url = Uri.http('192.168.18.59:3000', 'mahasiswa');
      var hasil = await http.put(
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

  void hapus(BuildContext context) async {
    if (!sedangLoading) {
      setState(() {
        sedangLoading = true;
      });

      var url = Uri.http('192.168.18.59:3000', 'mahasiswa');
      var hasil = await http.delete(
        url,
        headers: {"token": "123456", "Content-Type": "application/json"},
        body: convert.jsonEncode({
          "nim": nim.text,
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
          widget.nama,
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
              enabled: false,
            ),
            Text("Nama"),
            TextFormField(
              controller: nama,
            ),
            Text("Alamat"),
            TextFormField(
              controller: alamat,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: sedangLoading
                        ? CircularProgressIndicator()
                        : Text("Simpan",
                            style: TextStyle(
                                color: Colors
                                    .white)), // Ubah warna teks menjadi putih.
                    onPressed: () => ubah(context),
                    style: ElevatedButton.styleFrom(
                      primary: Colors
                          .blue, // Ubah warna latar belakang tombol "Simpan" menjadi biru.
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    child: sedangLoading
                        ? CircularProgressIndicator()
                        : Text("Hapus",
                            style: TextStyle(
                                color: Colors
                                    .white)), // Ubah warna teks menjadi putih.
                    onPressed: () => hapus(context),
                    style: ElevatedButton.styleFrom(
                      primary: Colors
                          .red, // Ubah warna latar belakang tombol "Hapus" menjadi merah.
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
