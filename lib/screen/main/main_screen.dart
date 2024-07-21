import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:warung_miku/config/end_point.dart';
import 'package:warung_miku/screen/pelanggan/tambah/tambah_pelanggan.dart';
import 'package:warung_miku/screen/pelanggan/update/update_pelanggan.dart';

import '../../model/pelanggan.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  late Future<List<Pelanggan>> pelanggans;

  Future<List<Pelanggan>> getDataPelanggan() async {
    final response = await http.get(Uri.parse(EndPoint.pelanggan));
    if (response.statusCode == 200) {
      List dp = jsonDecode(response.body);
      //print(response.body);
      return dp.map((e) => Pelanggan.fromJson(e)).toList();
    } else {
      throw Exception("Error when fetching data");
    }
  }

  Future<void> deleteData(String id) async {
    final url = Uri.parse(EndPoint.pelanggan + "/${id}");
    final del = await http.delete(url);
    setState(() {
      pelanggans = getDataPelanggan();
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pelanggans = getDataPelanggan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: FutureBuilder(
            future: getDataPelanggan(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Pelanggan> pg = snapshot.data!;
                if (pg.length > 0) {
                  return showPelanggan(pg);
                } else {
                  return Center(child: Text("Data Tidak Tersedia"));
                }
              } else {
                if (snapshot.error == null) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Text("Error Fetching Data Failed");
                }
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TambahPelanggan()));
        },
      ),
    );
  }

  Widget showPelanggan(List<Pelanggan> pelanggan) {
    return ListView.builder(
      itemCount: pelanggan.length,
      itemBuilder: (context, index) {
        return showCardPelanggan(pelanggan[index]);
      },
    );
  }

  Widget showCardPelanggan(Pelanggan pg) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(10),
        child: ListTile(
          title: Text(pg.nama_pelanggan,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          subtitle: Text(pg.nama_pelanggan),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            InkWell(
              child: Icon(Icons.edit, color: Colors.yellow),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdatePelanggan(pg: pg)));
              },
            ),
            InkWell(
              child: Icon(Icons.delete, color: Colors.red),
              onTap: () {
                dialog(pg.id);
              },
            )
          ]),
        ),
      ),
    );
  }

  dialog(String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Konfirmasi"),
            content: Text("Apakah anda ingin menghapus data?"),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text("Hapus"),
                onPressed: () {
                  deleteData(id);
                },
              ),
            ],
          );
        });
  }
}
