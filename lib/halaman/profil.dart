import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profil extends StatefulWidget {
  ProfilState createState() => ProfilState();
}

class ProfilState extends State<Profil> {
  bool _isExpanded = false;

  TextStyle whiteText = TextStyle(
    color: Colors.white,
  );

  TextStyle blackText = TextStyle(
    color: Colors.black,
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Universitas"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Image(
              image: AssetImage("assets/foto.png"),
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Card(
              child: ExpansionTile(
                initiallyExpanded: _isExpanded,
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    _isExpanded = expanded;
                  });
                },
                title: Center(
                  child: Text(
                    "Profil",
                    style: GoogleFonts.notoSansJavanese(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 30,
                    ),
                  ),
                ),
                trailing: Icon(
                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "Universitas Duta Bangsa adalah salah satu universitas swasta di Indonesia yang berada di Kota Surakarta, Provinsi Jawa Tengah.",
                      style: blackText,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: ExpansionTile(
                initiallyExpanded: _isExpanded,
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    _isExpanded = expanded;
                  });
                },
                title: Center(
                  child: Text(
                    "Visi",
                    style: GoogleFonts.notoSansJavanese(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 30,
                    ),
                  ),
                ),
                trailing: Icon(
                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "Menjadi Universitas yang unggul di Bidang Bisnis dan Kewirausahaan di tingkat global pada tahun 2038",
                      style: blackText,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: ExpansionTile(
                initiallyExpanded: _isExpanded,
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    _isExpanded = expanded;
                  });
                },
                title: Center(
                  child: Text(
                    "Misi",
                    style: GoogleFonts.notoSansJavanese(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 30,
                    ),
                  ),
                ),
                trailing: Icon(
                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "1. Menyelenggarakan pendidikan berbasis kewirausahaan dan bisnis dalam rangka menyiapkan SDM yang Mandiri, Inovatif, Visioner, beriman dan berorientasi Global",
                      style: blackText,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "2. Melakukan penelitian inovatif dan kreatif yang dapat meningkatkan keunggulan dan daya saing bangsa",
                      style: blackText,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "3. Meimplementasikan hasil teknologi dan penelitian dalam rangka meningkatkan derajat kesejahteraan masyarakat",
                      style: blackText,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "4. Menjalin kerjasama dalam dan luar negeri yang bermanfaat bagi kemajuan Universitas dan pengembangan keilmuan dan teknologi secara universal",
                      style: blackText,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
