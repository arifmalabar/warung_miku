import 'package:warung_miku/config/end_point.dart';
import 'package:warung_miku/repository/base_repository.dart';

import '../model/barang.dart';

class BarangRepository extends BaseRepository {
  late Future<List<Barang>> barangs;
  BarangRepository(String urls) {
    super.url = Uri.parse(urls);
  }
}
