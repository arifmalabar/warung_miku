class Barang {
  String nama_barang;
  int kategori;
  String stok;
  String id;
  Barang(
      {required this.nama_barang,
      required this.kategori,
      required this.stok,
      required this.id});
  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
        nama_barang: json['nama_barang'],
        kategori: json['kategori'],
        stok: json['stok'],
        id: json['id']);
  }
}
