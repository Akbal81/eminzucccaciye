
import 'dart:convert';
import 'package:eminzucccaciye/arayuz/sayfalar/detay.dart';
import 'package:eminzucccaciye/data/arama_yeri.dart';
import 'package:eminzucccaciye/data/urunler_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  Future<List<Urunler>> fetchUrunler() async {
    final response = await http.get(Uri.parse('https://www.eminticaret.com/mobilyonetim/json.php?c=urunList&code=emin2017&date=0'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      List<dynamic> jsonList = jsonMap['urunler'];
      return jsonList.map((json) => Urunler.fromJson(json)).toList();
    } else {
      throw Exception('Yüklemede Sorun oldu -mış');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anasayfa"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: AramaYeri(),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Urunler>>(
        future: fetchUrunler(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            var urunlerList = snapshot.data!;
            return GridView.builder(
              itemCount: urunlerList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.8,
              ),
              itemBuilder: (context, index) {
                var urun = urunlerList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detay(urun: urun),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "${urun.name}",
                          style: TextStyle(fontSize: 14),
                        ),
                        if (urun.resimler.isNotEmpty)
                          Image.network(urun.resimler[0])
                        else
                          Placeholder(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${urun.fiyat} ₺",
                              style: TextStyle(fontSize: 14),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print("${urun.name} Sepette");
                              },
                              child: Text("Sepet"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("Ürün bulunamadı -mış"));
          }
        },
      ),
    );
  }
}
