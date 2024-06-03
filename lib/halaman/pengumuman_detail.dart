import 'package:flutter/material.dart';

class PengumumanDetail extends StatefulWidget {
  const PengumumanDetail({Key? key, required this.namapengumuman, required this.isipengumuman})
      : super(key: key);
  final String namapengumuman;
  final String isipengumuman;
  DokumenDetailState createState() => DokumenDetailState();
}

class DokumenDetailState extends State<PengumumanDetail> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.namapengumuman,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [Text(widget.isipengumuman)]),
      ),
    );
  }
}