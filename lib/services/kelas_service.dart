import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:bayarspp_app/locals/secure_storage.dart';
import 'package:bayarspp_app/models/history.dart';

import '../constants/api_config.dart';

class KelasService {
  KelasService._();
  static Future<List<Kelas>?> getKelas() async {
    log('RESPONSE $getKelas() CEK');
    try {
      const url = '${ApiConfig.baseUrl}/${ApiConfig.kelasEndpoint}';
      final token = await SecureStorage.getToken();
      final header = {
        'authorization': 'Bearer $token',
      };
      log('Sending GET request to: $url');
      final response = await dio.get(url, options: Options(headers: header));
      log('Response Data: ${response.data}');
      if (response.statusCode == 200) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == true) {
          final List listDataJson = responseJson['data'];
          List<Kelas> kelas = [];
          for (final json in listDataJson) {
            kelas.add(Kelas.fromJson(json));
          }
          log('${kelas.length} PANJANG');
          return kelas;
        }
      }
    }
    catch (e,st) {
      log('Error get Kelas $e, $st');
      return null;
    }
    return null;
  }
}
