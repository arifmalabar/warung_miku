import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:warung_miku/config/end_point.dart';

import '../../../model/barang.dart';

class UpdateBarang extends StatefulWidget {
  late Barang brg;
  UpdateBarang({required this.brg});
  @override
  State<StatefulWidget> createState() {
    return UpdateBarangState();
  }
}

class UpdateBarangState extends State<UpdateBarang> {
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
    final uri = Uri.parse(EndPoint.barang + "/${widget.brg.id}");
    Map<String, dynamic> data = {
      "nama_barang": nama.text,
      "kategori": pilihkategori,
      "stok": stok.text
    };
    try {
      final response = await http.put(uri,
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      if (response.reasonPhrase == "OK") {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      } else {
        print("gagal : ${response.reasonPhrase}");
      }
    } catch (e) {}
  }

  void fillForm() {
    nama.text = widget.brg.nama_barang;
    stok.text = widget.brg.stok;
    pilihkategori = widget.brg.kategori;
  }

  void initState() {
    super.initState();
    fillForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Barang")),
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
      child: Text("Update Barang"),
      style:
          ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
    );
  }
}
