import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:warung_miku/config/end_point.dart';
import 'package:warung_miku/repository/barang_repository.dart';
import 'package:warung_miku/screen/barang/tambah/tambah_barang.dart';
import 'package:warung_miku/screen/barang/update/update_barang.dart';

import '../../model/barang.dart';
import '../../repository/base_repository.dart';
import 'package:http/http.dart' as http;

class BarangScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BarangScreenState();
  }
}

class BarangScreenState extends State<BarangScreen> {
  late Future<List<Barang>> barangs;
  Future<void> deleteData(String id) async {
    final url = Uri.parse(EndPoint.barang + "/${id}");
    try {
      final response = await http.delete(url);
      if (response.reasonPhrase == "OK") {
        setState(() {
          barangs = getData();
        });
        Navigator.pop(context);
      } else {
        print("Error : ${response.reasonPhrase}");
      }
    } catch (e) {}
  }

  Future<List<Barang>> getData() async {
    final response = await http.get(Uri.parse(EndPoint.barang));
    if (response.statusCode == 200) {
      List dp = jsonDecode(response.body);
      return dp.map((e) => Barang.fromJson(e)).toList();
    } else {
      throw Exception("Error when fetching data");
    }
  }

  void initState() {
    super.initState();
    barangs = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: FutureBuilder(
          future: barangs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Barang> data = snapshot.data!;
              return listBarang(data);
            } else {
              if (snapshot.error == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Text("Error Fetching Data Failed");
              }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TambahBarang()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget listBarang(List<Barang> list_barang) {
    return ListView.builder(
      itemCount: list_barang.length,
      itemBuilder: (context, index) {
        return cardBarang(list_barang[index]);
      },
    );
  }

  Widget cardBarang(Barang brg) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(5),
        child: ListTile(
          title: Text(brg.nama_barang),
          subtitle: Text("Stok : ${brg.stok}"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                child: Icon(Icons.edit),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateBarang(brg: brg)));
                },
              ),
              InkWell(
                child: Icon(Icons.delete),
                onTap: () {
                  confirmDialog(brg.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  confirmDialog(String id) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm"),
          content: Text("Apakah anda ingin menghapus data ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                deleteData(id);
              },
              child: Text("Hapus"),
            )
          ],
        );
      },
    );
  }
}
