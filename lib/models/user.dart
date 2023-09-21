class User {
  final int id;
  final String name;
  final String email;
  final Siswa siswa;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.siswa,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    siswa: Siswa.fromJson(json["siswa"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "siswa": siswa.toJson(),
  };
}

class Siswa {
  final int id;
  final String nisn;
  final String name;
  final String nis;
  final String alamat;
  final String noTelp;
  final int userId;
  final int kelasId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Siswa({
    required this.id,
    required this.nisn,
    required this.name,
    required this.nis,
    required this.alamat,
    required this.noTelp,
    required this.userId,
    required this.kelasId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Siswa.fromJson(Map<String, dynamic> json) => Siswa(
    id: json["id"],
    nisn: json["nisn"],
    name: json["name"],
    nis: json["nis"],
    alamat: json["alamat"],
    noTelp: json["no_telp"],
    userId: json["user_id"],
    kelasId: json["kelas_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nisn": nisn,
    "name": name,
    "nis": nis,
    "alamat": alamat,
    "no_telp": noTelp,
    "user_id": userId,
    "kelas_id": kelasId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
