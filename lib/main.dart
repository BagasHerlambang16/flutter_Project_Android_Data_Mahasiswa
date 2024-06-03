import 'package:flutter/material.dart';
import 'package:flutter_project/halaman/berita.dart';
import 'package:flutter_project/halaman/pengumuman.dart';
import 'package:flutter_project/halaman/informasi.dart';
import 'package:flutter_project/halaman/gallery.dart';
import 'package:flutter_project/halaman/mahasiswa.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


import 'halaman/profil.dart';


Widget widgetMenu(BuildContext context) {
  return new Container(
    child: GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      crossAxisSpacing: 5.0,
      mainAxisSpacing: 5.0,
      childAspectRatio: 3 / 2,
      children: [
        GestureDetector(
          onTap: () {
            print("Klik menu profil");

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Profil(),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromARGB(255, 245, 0, 0), 
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.account_circle, // Ganti dengan ikon yang sesuai
                    size: 50,
                    color: Color.fromARGB(255, 245, 0, 0), // Warna ikon
                    ),
                Text(
                  "Profil",
                  style: TextStyle(
                    color: Color.fromARGB(255, 245, 0, 0), // Warna teks
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            print("Klik menu Berita");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BeritaPage(),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromARGB(255, 204, 201, 32), 
                width: 1.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.info, // Ganti dengan ikon yang sesuai
                  size: 50,
                  color: Color.fromARGB(255, 204, 201, 32), 
                ),
                Text(
                  "Berita",
                  style: TextStyle(
                    color: Color.fromARGB(255, 204, 201, 32),  
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            print("Klik menu Informasi");
            // Tambahkan logika navigasi atau tindakan lain di sini
            Navigator.push(context,
            MaterialPageRoute(builder: (context)=> Informasi(),
            ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromARGB(255, 8, 4, 231), 
                width: 1.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.library_books, // Ganti dengan ikon yang sesuai
                  size: 50,
                  color: Color.fromARGB(255, 8, 4, 231), 
                ),
                Text(
                  "Informasi",
                  style: TextStyle(
                    color: Color.fromARGB(255, 8, 4, 231),  
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            print("Klik menu Gallery");
            Navigator.push(context,
            MaterialPageRoute(builder: (context)=> Gallery(),
            ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromARGB(255, 245, 0, 0), 
                width: 1.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo, // Ganti dengan ikon yang sesuai
                  size: 50,
                  color: Color.fromARGB(255, 245, 0, 0), 
                ),
                Text(
                  "Gallery",
                  style: TextStyle(
                    color: Color.fromARGB(255, 245, 0, 0),  
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            print("Klik menu Pengumuman");
            Navigator.push(context,
            MaterialPageRoute(builder: (context)=> Pengumuman(),
            ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromARGB(255, 204, 201, 32), 
                width: 1.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.document_scanner, // Ganti dengan ikon yang sesuai
                  size: 50,
                  color: Color.fromARGB(255, 204, 201, 32), 
                ),
                Text(
                  "Pengumuman",
                  style: TextStyle(
                    color: Color.fromARGB(255, 204, 201, 32),  
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            print("Klik menu Mahasiswa");
            Navigator.push(context,
            MaterialPageRoute(builder: (context)=> Mahasiswa(),
            ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromARGB(255, 8, 4, 231), 
                width: 1.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.people, // Ganti dengan ikon yang sesuai
                  size: 50,
                  color: Color.fromARGB(255, 8, 4, 231), 
                ),
                Text(
                  "Mahasiswa",
                  style: TextStyle(
                    color: Color.fromARGB(255, 8, 4, 231), 
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
Future<List<dynamic>> getInfo() async {
  var url = Uri.https('udb.ac.id', 'json/info-akademik');
  var hasil = await http.get(url);
  return convert.jsonDecode(hasil.body);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Universitas Duta Bangsa'),
      
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List> responseInfo;

  void _incrementCounter() {
    setState(() {});
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
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(widget.title),
      ), 
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Image(image: AssetImage("assets/1.png"),
            width: 200,
            height: 200,
            ),
              widgetMenu(context),
            ],
          ),
        ),
      
    );
  }
}
