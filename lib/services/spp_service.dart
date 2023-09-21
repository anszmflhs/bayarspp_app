import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:bayarspp_app/locals/secure_storage.dart';
import 'package:bayarspp_app/models/history.dart';

import '../constants/api_config.dart';

class SppService {
  SppService._();
  static Future<List<Spp>?> getSpp() async {
    log('RESPONSE $getSpp() CEK');
    try {
      const url = '${ApiConfig.baseUrl}/${ApiConfig.sppEndpoint}';
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
          List<Spp> spp = [];
          for (final json in listDataJson) {
            spp.add(Spp.fromJson(json));
          }
          log('${spp.length} PANJANG');
          return spp;
        }
      }
    }
    catch (e,st) {
      log('Error get Spp $e, $st');
      return null;
    }
    return null;
  }
}
