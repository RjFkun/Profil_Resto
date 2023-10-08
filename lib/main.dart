import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final resto = <String, String>{};

  MainApp({super.key}) {
    resto['name'] = 'Sedaprasa Dapur Nusantara';
    resto['img'] = 'resto-img.jpg';
    resto['email'] = 'sedaprasa@gmail.com';
    resto['phone'] = '+6281901245666';
    resto['maps_url'] = 'https://maps.google.com/?q=-6.98263889,110.40919444';
    resto['description'] =
        """Sedaprasa adalah restoran seafood yang memiliki konsep yang unik, yaitu menggabungkan unsur tradisional dan modern.

Menu makanan di Restoran Sedaprasa sangat beragam, mulai dari hidangan seafood, hidangan nusantara, hingga hidangan internasional.""";
    resto['address'] =
        'Jl. Peres No.197, Kuningan, Kec. Semarang Utara, Kota Semarang, Jawa Tengah 50176';
    resto['open_hour'] = '11.00';
    resto['close_hour'] = '21.00';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Profil Restoran',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Aplikasi Profil Restoran',
              style: TextStyle(color: Colors.black87)),
          backgroundColor: Color.fromARGB(255, 86, 253, 52),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: textBordered(Color.fromARGB(221, 247, 112, 1), resto['name'] ?? ''),
              ),
              Image(image: AssetImage('assets/${resto['img']}')),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    btnMenu(Icons.email_rounded, Color.fromARGB(255, 140, 78, 255),
                        'mailto:${resto['email']}?subject=Tanya Seputar Resto'),
                    btnMenu(Icons.phone, Color.fromARGB(255, 187, 61, 2), 'tel:${resto['phone']}'),
                    btnMenu(Icons.map, const Color.fromARGB(255, 5, 96, 172), resto['maps_url'] ?? '')
                  ],
                ),
              ),
              textHeading('Deskripsi', 22),
              const SizedBox(height: 12),
              textContent(resto['description'] ?? ''),
              textHeading('List Menu', 22),
              const SizedBox(height: 12),
              Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      listMenu('Tahu Cabe Garam', '18.500'),
                      listMenu('Sup Buntut', '58.500'),
                      listMenu('Kerang Ijo Tauco', '29.500'),
                      listMenu('Gurame Bakar Rempah Ayu', '108.500'),
                      listMenu('Es Campur sedaprasa', '22.500'),
                      listMenu('Es Podeng', '22.500'),
                    ],
                  )),
              textHeading('Alamat', 22),
              const SizedBox(height: 12),
              textContent(resto['address'] ?? ''),
              textHeading('Jam Buka', 22),
              const SizedBox(height: 12),
              textContent('- Buka: ${resto['open_hour']}'),
              textContent('- Tutup: ${resto['close_hour']}'),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Container listMenu(String menuName, String price) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            children: [
              Text('- ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(menuName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Rp $price')
            ],
          ),
        ],
      ),
    );
  }

  Container textBordered(Color bgColor, String teks) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      decoration: BoxDecoration(color: bgColor),
      child: Text(teks,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
    );
  }

  Container textContent(String content) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        content,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Container textHeading(String content, double size) {
    return Container(
        padding: const EdgeInsets.only(top: 20, bottom: 4),
        width: double.infinity,
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.black87))),
        child: Text(content,
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.bold,
                color: Colors.black87)));
  }

  SizedBox btnMenu(IconData icon, var bgColor, String url) {
    return SizedBox(
      width: 110,
      child: ElevatedButton(
        onPressed: () async {
          launch(url);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: bgColor, foregroundColor: Colors.white),
        child: Icon(icon),
      ),
    );
  }

  Future<void> launch(String uri) async {
    final url = Uri.parse(uri);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      SnackBar(
        content: Text('Tidak dapat memanggil: $uri.'),
      );
    }
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Tidak dapat memanggil: $uri');
    }
  }
}
