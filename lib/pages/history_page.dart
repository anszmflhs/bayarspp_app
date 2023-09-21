import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:bayarspp_app/services/history_service.dart';
import 'package:bayarspp_app/models/history.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _isLoading = true;
  List<History> histories = [];

  @override
  void initState() {
    super.initState();
    HistoryService.getHistory().then((value) {
      setState(() {
        histories = value!;
        _isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final history = histories[index];
                log('${history.toJson()}');
                return Card(
                  // Add the return statement here
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama : ' + (history.user.siswa.name ?? ''),
                            // Ensure null safety
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                          Text(
                            'Jurusan : ' + (history.kelas.jurusan ?? ''),
                            // Ensure null safety
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                          Text(
                            'Nominal : ' +
                                (history.spp.nominal.toString() ?? ''),
                            // Ensure null safety
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),Text(
                            'Status : ' +
                                (history.status ?? ''),
                            // Ensure null safety
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: histories.length,
            ),
          )
        ],
      ),
    );
  }
}
