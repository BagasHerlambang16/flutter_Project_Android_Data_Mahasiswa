import 'package:flutter/material.dart';

class InformasiDetail extends StatefulWidget {
  const InformasiDetail({
    Key? key,
    required this.judul,
    required this.konten,
    required this.gambar,
  }) : super(key: key);
  final String judul;
  final String konten;
  final String gambar;
  InformasiDetailState createState() => InformasiDetailState();
}

class InformasiDetailState extends State<InformasiDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.judul,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.network(
                    widget.gambar,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.konten,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
