import 'package:flutter/material.dart';
import 'package:warung_miku/screen/account/account_screen.dart';
import 'package:warung_miku/screen/barang/barang_screen.dart';
import 'package:warung_miku/screen/main/main_screen.dart';
import 'package:warung_miku/screen/pelanggan/tambah/tambah_pelanggan.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainAppState();
  }
}

class MainAppState extends State<MainApp> {
  int screenindex = 0;
  final screen = [MainScreen(), BarangScreen(), AccountScreen()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MikuApp",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Miku App"),
        ),
        body: Scaffold(
          body: screen[screenindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: screenindex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance), label: "Barang"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Account"),
            ],
            onTap: (value) {
              setState(() {
                screenindex = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
