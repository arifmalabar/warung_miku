import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:warung_miku/config/end_point.dart';
import 'package:warung_miku/screen/main/main_screen.dart';

import '../../../model/pelanggan.dart';

class UpdatePelanggan extends StatefulWidget {
  Pelanggan pg;

  UpdatePelanggan({required this.pg});
  @override
  State<StatefulWidget> createState() {
    return UpdatePelangganState();
  }
}

class UpdatePelangganState extends State<UpdatePelanggan> {
  bool jk = true;
  int kategori = 0;

  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();

  void initState() {
    super.initState();
    nama.text = widget.pg.nama_pelanggan;
    alamat.text = widget.pg.alamat;
  }

  Future<void> postData() async {
    final url = Uri.parse(EndPoint.pelanggan + "/${widget.pg.id}");
    final Map<String, dynamic> reqData = {
      "nama_pelanggan": nama.text,
      "jenis_kelamin": jk,
      "type": kategori,
      "alamat": alamat.text
    };
    try {
      final response = await http.put(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(reqData));
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Pelanggan"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: [
            Text("Nama"),
            TextFormField(
              controller: nama,
              decoration: InputDecoration(hintText: "Masukan Nama"),
            ),
            showGap(),
            Text("Jenis Kelamin"),
            ListTile(
              leading: Radio<bool>(
                groupValue: jk,
                value: true,
                onChanged: (v) {
                  setState(() {
                    jk = v!;
                  });
                },
              ),
              title: Text("Pria"),
            ),
            ListTile(
              leading: Radio<bool>(
                groupValue: jk,
                value: false,
                onChanged: (v) {
                  setState(() {
                    jk = v!;
                  });
                },
              ),
              title: Text("Wanita"),
            ),
            showGap(),
            Text("Kategori"),
            ListTile(
              leading: Radio<int>(
                groupValue: kategori,
                value: 0,
                onChanged: (value) {
                  setState(() {
                    kategori = value!;
                  });
                },
              ),
              title: Text("Silver"),
            ),
            ListTile(
              leading: Radio<int>(
                groupValue: kategori,
                value: 1,
                onChanged: (value) {
                  setState(() {
                    kategori = value!;
                  });
                },
              ),
              title: Text("Gold"),
            ),
            ListTile(
              leading: Radio<int>(
                groupValue: kategori,
                value: 2,
                onChanged: (value) {
                  setState(() {
                    kategori = value!;
                  });
                },
              ),
              title: Text("Bronze"),
            ),
            showGap(),
            Text("Alamat"),
            TextFormField(
              controller: alamat,
              decoration: InputDecoration(hintText: "Masukan Alamat..."),
              maxLines: 10,
            ),
            showGap(),
            showGap(),
            ElevatedButton(
              child: Text("Update Data"),
              onPressed: () {
                postData();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget showGap() {
    return Container(height: 10);
  }
}
