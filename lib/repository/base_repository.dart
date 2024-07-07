import 'dart:convert';

import 'package:warung_miku/interface/data_interface.dart';
import 'package:http/http.dart' as http;

import '../config/end_point.dart';

class BaseRepository {
  late Uri url;
  static Future<void> deleteData(String id) async {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  static Future<List> getData() async {
    final response = await http.get(Uri.parse(EndPoint.barang));
    if (response.statusCode == 200) {
      List dp = jsonDecode(response.body);
      return dp;
    } else {
      throw Exception("Error when fetching data");
    }
  }

  static Future<void> postData(String data) async {
    // TODO: implement postData
    throw UnimplementedError();
  }

  static Future<void> updateData(String data, String id) async {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
