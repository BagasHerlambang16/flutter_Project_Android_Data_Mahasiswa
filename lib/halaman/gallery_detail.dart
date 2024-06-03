import 'package:flutter/material.dart';

class GalleryDetail extends StatefulWidget {
  const GalleryDetail({
    Key? key,
    required this.nama,
    required this.gambar,
  }) : super(key: key);
  final String nama;
  final String gambar;
  GalleryDetailState createState() => GalleryDetailState();
}

class GalleryDetailState extends State<GalleryDetail> {
  @override
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
