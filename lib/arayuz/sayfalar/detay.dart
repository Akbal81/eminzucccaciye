
import 'package:eminzucccaciye/data/urunler_class.dart';
import 'package:flutter/material.dart';
import 'package:eminzucccaciye/data/urunler_class.dart';

class Detay extends StatelessWidget {
  final Urunler urun;

  Detay({required this.urun});

  // HTML etiketlerini temizlemek için bir yardımcı fonksiyon
  String removeHtmlTags(String html) {
    final RegExp exp = RegExp(r'<[^>]*>');
    return html.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(urun.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ürün resimlerini gösteren kaydırılabilir bölüm
              if (urun.resimler.isNotEmpty)
                Container(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: urun.resimler.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        urun.resimler[index],
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      );
                    },
                  ),
                ),
              SizedBox(height: 16.0),
              // Ürün marka ve adını gösteren bölüm
              Center(
                child: Text(
                  urun.marka_ad,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  urun.name,
                  style: TextStyle(fontSize: 24, color: Colors.teal),
                ),
              ),
              SizedBox(height: 16.0),
              // Ürün fiyatları ve diğer detayları gösteren bölüm
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Fiyat: ${urun.fiyat} ₺",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Market Fiyat: ${urun.marketFiyat} ₺",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Maliyet: ${urun.maliyet} ₺",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Kdv: ${removeHtmlTags(urun.kdv.toString())}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16.0),
              // Ürün açıklaması, birimler ve diğer detaylar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Açıklama",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0), // Başlık ve açıklama arasına boşluk ekler
                    Text(
                      removeHtmlTags(urun.aciklama),
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Birimler: ${removeHtmlTags(urun.birimler)}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Detay: ${removeHtmlTags(urun.detay)}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Ürün Kodu: ${removeHtmlTags(urun.urun_kod)}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Stok: ${removeHtmlTags(urun.stock)}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Barcode: ${removeHtmlTags(urun.barcode)}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
