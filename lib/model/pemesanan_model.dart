class PemesananModel {
  final int? idPemesanan;
  final int? idPaket;
  final String? namaPengguna;
  final String? noWhatsapp;
  final String? jenjangPendidikan;
  final int? jumlahPeserta;
  final String? tanggalBooking;
  final String? waktuAwal;
  final String? waktuAkhir;
  final String? tanggalPesan;
  final String? status;
  final String? deskripsi;
  final String? jenis_paket;

  const PemesananModel(
      {this.idPemesanan,
      this.idPaket,
      this.namaPengguna,
      this.noWhatsapp,
      this.jenjangPendidikan,
      this.jumlahPeserta,
      this.tanggalBooking,
      this.waktuAwal,
      this.waktuAkhir,
      this.tanggalPesan,
      this.status,
      this.deskripsi,
      this.jenis_paket});

  factory PemesananModel.fromJson(Map<String, dynamic> json) => PemesananModel(
      idPemesanan: json['id_pemesanan'] ?? 0,
      idPaket: json['id_paket'] ?? 0,
      namaPengguna: json['nama_pengguna'] ?? '',
      noWhatsapp: json['no_whatsapp'] ?? '',
      jenjangPendidikan: json['jenjang_pendidikan'] ?? '',
      jumlahPeserta: int.parse('0${json['jumlah_peserta']}') ?? 0,
      tanggalBooking: json['tanggal_booking'] ?? '',
      waktuAwal: json['waktu_awal'] ?? '',
      waktuAkhir: json['waktu_akhir'] ?? '',
      tanggalPesan: json['tanggal_pesan'] ?? '',
      status: json['status'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      jenis_paket: json['jenis_paket'] ?? '');

  Map<String, dynamic> toJson() => {
        "id_pemesanan": idPemesanan,
        "id_paket": idPaket,
        "nama_pengguna": namaPengguna,
        "no_whatsapp": noWhatsapp,
        "jenjang_pendidikan": jenjangPendidikan,
        "jumlah_peserta": jumlahPeserta,
        "tanggal_booking": tanggalBooking,
        "waktu_awal": waktuAwal,
        "waktu_akhir": waktuAkhir,
        "tanggal_pesan": tanggalPesan,
        "status": status,
        "deskripsi": deskripsi,
        "jenis_paket": jenis_paket
      };
}
