class Urunler {
  final String name;
  final int urun_Id;
  final String urun_kod;
  final int marka_kod;
  final String marka_ad;
  final String birimler;
  final String detay;
  final String aciklama;
  final List<String> resimler; // Güncellenmiş tip
  final double fiyat;
  final double marketFiyat;
  final double kdv;
  final String stock;
  final double maliyet;
  final String barcode;

  Urunler({
    required this.name,
    required this.resimler,
    required this.urun_Id,
    required this.urun_kod,
    required this.marka_kod,
    required this.marka_ad,
    required this.birimler,
    required this.detay,
    required this.aciklama,
    required this.fiyat,
    required this.marketFiyat,
    required this.kdv,
    required this.stock,
    required this.maliyet,
    required this.barcode,
  });

  factory Urunler.fromJson(Map<String, dynamic> json) {
    return Urunler(
      name: json['name'] as String,
      urun_Id: int.tryParse(json['urun_Id'].toString()) ?? 0,
      urun_kod: json['urun_kod'],
      marka_kod: int.tryParse(json['marka_kod'].toString()) ?? 0,
      marka_ad: json['marka_ad'],
      birimler: json['birimler'],
      detay: json['detay'],
      aciklama: json['aciklama'],
      resimler: List<String>.from(json['resimler'] as List<dynamic>), // Güncellenmiş
      fiyat: double.tryParse(json['fiyat'].toString()) ?? 0,
      marketFiyat: double.tryParse(json['marketFiyat'].toString()) ?? 0,
      kdv: double.tryParse(json['kdv'].toString()) ?? 0.0,
      stock: json['stock'],
      maliyet: double.tryParse(json['maliyet'].toString()) ?? 0,
      barcode: json['barcode'],
    );
  }
}
