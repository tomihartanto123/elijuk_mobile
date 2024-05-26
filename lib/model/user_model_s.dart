class UserModel {
  final String idUser;
  final String role;
  final String email;
  final String kataSandi;
  final String namaPengguna;
  final String? foto; // nullable string for foto
  final String noHp;

  UserModel({
    required this.idUser,
    required this.role,
    required this.email,
    required this.kataSandi,
    required this.namaPengguna,
    this.foto,
    required this.noHp,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json['id_user'] as String,
        role: json['role'] as String,
        email: json['email'] as String,
        kataSandi: json['kata_sandi'] as String,
        namaPengguna: json['nama_pengguna'] as String,
        foto: json['foto'] as String?,
        noHp: json['no_hp'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id_user': idUser,
        'role': role,
        'email': email,
        'kata_sandi': kataSandi,
        'nama_pengguna': namaPengguna,
        'foto': foto,
        'no_hp': noHp,
      };
}
