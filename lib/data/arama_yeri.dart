
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'urunler_class.dart'; // Urunler sınıfını içeren dosya
import 'package:eminzucccaciye/arayuz/sayfalar/detay.dart'; // Detay sayfasını içeren dosya

class AramaYeri extends SearchDelegate<Urunler> {
  // API'dan ürünleri çekmek için fonksiyon
  Future<List<Urunler>> fetchUrunler() async {
    final response = await http.get(Uri.parse('https://www.eminticaret.com/mobilyonetim/json.php?c=urunList&code=emin2017&date=0'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      List<dynamic> jsonList = jsonMap['urunler'];
      return jsonList.map((json) => Urunler.fromJson(json)).toList();
    } else {
      throw Exception('Yüklemede Sorun oldu');
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Urunler>>(
      future: fetchUrunler(), // API'dan ürünleri çek
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          var urunlerList = snapshot.data!;
          var filteredList = urunlerList.where((urun) {
            return urun.name.toLowerCase().contains(query.toLowerCase());
          }).toList();

          return ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              var urun = filteredList[index];
              return ListTile(
                title: Text(urun.name),
                subtitle: Text("${urun.fiyat} ₺"),
                leading: urun.resimler.isNotEmpty
                    ? Image.network(
                  urun.resimler[0],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                    : Icon(Icons.image),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detay(urun: urun),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return Center(child: Text("Ürün bulunamadı"));
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close; // Arama penceresini kapat
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }
}
