class Pelanggan {
  String nama_pelanggan;
  bool jenis_kelamin;
  int type;
  String alamat;
  String id;

  Pelanggan(
      {required this.nama_pelanggan,
      required this.jenis_kelamin,
      required this.type,
      required this.alamat,
      required this.id});

  factory Pelanggan.fromJson(Map<String, dynamic> json) {
    return Pelanggan(
        nama_pelanggan: json['nama_pelanggan'],
        jenis_kelamin: json['jenis_kelamin'],
        type: json['type'],
        alamat: json['alamat'],
        id: json['id']);
  }
}
