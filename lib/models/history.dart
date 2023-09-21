import 'package:bayarspp_app/models/user.dart';

class History {
  final int id;
  final int userId;
  final int kelasId;
  final int sppId;
  // final DateTime tanggalBayar;
  final String buktiPembayaran;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;
  final Kelas kelas;
  final Spp spp;

  History({
    required this.id,
    required this.userId,
    required this.kelasId,
    required this.sppId,
    // required this.tanggalBayar,
    required this.buktiPembayaran,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.kelas,
    required this.spp,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
    id: json["id"],
    userId: json["user_id"],
    kelasId: json["kelas_id"],
    sppId: json["spp_id"],
    // tanggalBayar: DateTime.parse(json["tanggal_bayar"]),
    buktiPembayaran: json["bukti_pembayaran"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
    kelas: Kelas.fromJson(json["kelas"]),
    spp: Spp.fromJson(json["spp"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "kelas_id": kelasId,
    "spp_id": sppId,
    // "tanggal_bayar": "${tanggalBayar.year.toString().padLeft(4, '0')}-${tanggalBayar.month.toString().padLeft(2, '0')}-${tanggalBayar.day.toString().padLeft(2, '0')}",
    "bukti_pembayaran": buktiPembayaran,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toJson(),
    "kelas": kelas.toJson(),
    "spp": spp.toJson(),
  };
}

class Kelas {
  final int id;
  final String jurusan;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Kelas({
    required this.id,
    required this.jurusan,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) => Kelas(
    id: json["id"],
    jurusan: json["jurusan"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "jurusan": jurusan,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Spp {
  final int id;
  final String nominal;
  final int kelasId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Spp({
    required this.id,
    required this.nominal,
    required this.kelasId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Spp.fromJson(Map<String, dynamic> json) => Spp(
    id: json["id"],
    nominal: json["nominal"],
    kelasId: json["kelas_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nominal": nominal,
    "kelas_id": kelasId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}