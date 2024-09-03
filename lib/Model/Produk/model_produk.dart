class Produk {
  int? id;
  String? namaProduk;
  String? kodeProduk;
  int? hargaProduk;
  String? jenisProduk;
  String? stokProduk;
  String? tanggalProduk;
  String? warnaProduk;

  Produk(
      {this.id,
      this.namaProduk,
      this.kodeProduk,
      this.hargaProduk,
      this.jenisProduk,
      this.stokProduk,
      this.tanggalProduk,
      this.warnaProduk});

  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
        id: obj['id'],
        kodeProduk: obj['kode_produk'],
        namaProduk: obj['nama_produk'],
        hargaProduk: obj['harga'],
        jenisProduk: obj['jenis'],
        stokProduk: obj['stok'],
        tanggalProduk: obj['jenis'],
        warnaProduk: obj['jenis']);
  }
}
