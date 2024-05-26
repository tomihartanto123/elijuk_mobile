import 'dart:convert';

class PaketModel {
  final String? idPaket;
  final String? jenisPaket;
  final String? deskripsi;
  final String? biaya;
  final String? foto;

  PaketModel({
    this.idPaket,
    this.jenisPaket,
    this.deskripsi,
    this.biaya,
    this.foto,
  });

  factory PaketModel.fromRawJson(String str) => PaketModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaketModel.fromJson(Map<String, dynamic> json) => PaketModel(
    idPaket: json["id_paket"],
    jenisPaket: json["jenis_paket"],
    deskripsi: json["deskripsi"],
    biaya: json["biaya"],
    foto: json["foto"],
  );

  Map<String, dynamic> toJson() => {
    "id_paket": idPaket,
    "jenis_paket": jenisPaket,
    "deskripsi": deskripsi,
    "biaya": biaya,
    "foto": foto,
  };
}
