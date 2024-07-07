import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:warung_miku/config/end_point.dart';

class TambahBarang extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TambahBarangState();
  }
}

class TambahBarangState extends State<TambahBarang> {
  TextEditingController nama = TextEditingController();
  TextEditingController stok = TextEditingController();
  final kategori = [
    "Makanan",
    "Pakaian",
    "Perabotan",
    "Elektronik",
    "Kendaraan"
  ];
  int pilihkategori = 0;
  Future<void> postData() async {
    final uri = Uri.parse(EndPoint.barang);
    Map<String, dynamic> data = {
      "nama_barang": nama.text,
      "kategori": pilihkategori,
      "stok": stok.text
    };
    try {
      final response = await http.post(uri,
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 201) {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      } else {
        print("gagal : ${response.reasonPhrase}");
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Barang")),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: [inputNama(), inputKategori(), inputStok(), btnSubmit()],
        ),
      ),
    );
  }

  Widget inputNama() {
    return ListTile(
      title: Text("Nama"),
      subtitle: TextFormField(
        controller: nama,
        decoration: InputDecoration(hintText: "Masukan Nama"),
      ),
    );
  }

  Widget inputKategori() {
    return ListTile(
      title: Text("Kategori"),
      subtitle: Wrap(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: kategori.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Radio<int>(
                  groupValue: pilihkategori,
                  value: index,
                  onChanged: (value) {
                    setState(() {
                      pilihkategori = value!;
                    });
                  },
                ),
                title: Text(kategori[index]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget inputStok() {
    return ListTile(
      title: Text("Stok"),
      subtitle: TextFormField(
        controller: stok,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(hintText: "Masukan Stok"),
      ),
    );
  }

  Widget btnSubmit() {
    return ElevatedButton(
      onPressed: () {
        postData();
      },
      child: Text("Tambah Barang"),
    );
  }
}
