import 'dart:io';

import 'package:dio/dio.dart';
import 'package:bayarspp_app/locals/secure_storage.dart';
import 'package:bayarspp_app/models/history.dart';

import '../constants/api_config.dart';

class HistoryService {
  HistoryService._();
  static Future<List<History>?> getHistory() async {
    print('RESPONSE $getHistory() CEK');
    try {
      const url = '${ApiConfig.baseUrl}/${ApiConfig.historyEndpoint}';
      final token = await SecureStorage.getToken();
      final header = {
        'authorization': 'Bearer $token',
      };
      print('Sending GET request to: $url');
      final response = await dio.get(url, options: Options(headers: header));
      print('Response Data: ${response.data}');
      if (response.statusCode == 200) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == true) {
          final List listDataJson = responseJson['data'];
          List<History> histories = [];
          for (final json in listDataJson) {
            histories.add(History.fromJson(json));
          }
          print('${histories.length} PANJANG');
          return histories;
        }
      }
    } catch (e, st) {
      print('Error get Histories $e, $st');
      return null;
    }
    return null;
  }

  static Future<void> createHistory({
    required String user_id,
    required String kelas_id,
    required String spp_id,
    File? bukti_pembayaran,
    required String status,
  }) async {
    try {
      const url = '${ApiConfig.baseUrl}/${ApiConfig.historyEndpoint}';
      final token = await SecureStorage.getToken();

      final header = {
        'authorization': 'Bearer $token',
      };

      if (bukti_pembayaran != null) {
        // Create a FormData object and attach the file to it
        FormData formData = FormData.fromMap({
          'user_id': user_id,
          'kelas_id': kelas_id,
          'spp_id': spp_id,
          'bukti_pembayaran': await MultipartFile.fromFile(bukti_pembayaran.path, filename: "bukti.png"),
          'status': status,
        });

        final response = await dio.post(url, data: formData, options: Options(headers: header));

        if (response.statusCode == 200) {
          final responseJson = response.data;
          final status = responseJson['status'];
          if (status == true) {
            await getHistory();
          }
        }
      }
    } catch (e, st) {
      print('Error CreateHistory : $e\nStacktrace : $st');
    }
  }
}
