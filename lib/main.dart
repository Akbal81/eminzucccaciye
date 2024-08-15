
import 'package:flutter/material.dart';
import 'package:eminzucccaciye/arayuz/sayfalar/anasayfa.dart'; // Anasayfa widget'ınızın yolu

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emin Züccaciye',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Anasayfa(), // Ana sayfanızı buradan başlatıyoruz
    );
  }
}
