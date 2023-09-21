import 'dart:io';

import 'package:bayarspp_app/locals/secure_storage.dart';
import 'package:bayarspp_app/models/history.dart';
import 'package:bayarspp_app/services/history_service.dart';
import 'package:bayarspp_app/services/kelas_service.dart';
import 'package:bayarspp_app/services/spp_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../main.dart';
import '../models/user.dart' as userval;

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final nameSiswa = TextEditingController();
  final nisSiswa = TextEditingController();
  final jurusanSiswa = TextEditingController();
  final nominalSpp = TextEditingController();

  // final tanggalBayar = TextEditingController();
  final buktiPembayaran = TextEditingController();
  final statusPembayaran = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool _isLoading = true;
  userval.User? user;

  List<Kelas> kelass = [];
  List<Spp> spps = [];

  String? klsId;
  String? sppsId;

  // String? tanggal_bayar;
  // String? bukti_pembayaran;

  File? _selectedImage;

  @override
  void initState() {
    SecureStorage.getUser().then((value) {
      setState(() {
        user = value;
        nameSiswa.text = value!.name ?? '';
        nisSiswa.text = value.siswa.nis ?? '';
      });
    });

    KelasService.getKelas().then((value) {
      if (value != null) {
        setState(() {
          kelass = value; // Populate 'kelass' with data from the service
        });
      }
      setState(() {
        _isLoading = false;
      });
    });
    SppService.getSpp().then((value) {
      if (value != null) {
        setState(() {
          spps = value; // Populate 'spps' with data from the service
        });
      }
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final returnedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (returnedImage == null) return;

      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    } catch (e) {
      print("Image picker error: $e");
    }
  }

  // Future<void> _selectedDate() async {
  //   DateTime? _picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2023),
  //     lastDate: DateTime(3000),
  //   );
  //
  //   if (_picked != null) {
  //     setState(() {
  //       tanggalBayar.text = _picked.toLocal().toString().split(" ")[0];
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 24, right: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Please input your payment :',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: nameSiswa,
                            readOnly: true,
                            enabled: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Nama Siswa Tidak Boleh Kosong';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              //
                            },
                            decoration: InputDecoration(
                                hintText: 'Customer Name :',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: nisSiswa,
                            readOnly: true,
                            enabled: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'NIS Siswa Tidak Boleh Kosong';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              //
                            },
                            decoration: InputDecoration(
                                hintText: 'NIS :',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          SizedBox(height: 10),
                          _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : DropdownButtonFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Pilih lagi';
                                    }
                                    return null;
                                  },
                                  hint: Text('Jurusan :'),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  items: List.generate(
                                      kelass.length,
                                      (index) => DropdownMenuItem(
                                          value: kelass[index].id.toString(),
                                          child: Text(
                                              '${kelass[index].jurusan}'))),
                                  onChanged: (val) {
                                    setState(() {
                                      klsId = val.toString();
                                    });
                                  }),
                          SizedBox(height: 10),
                          _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : DropdownButtonFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Pilih lagi';
                                    }
                                    return null;
                                  },
                                  hint: Text('Nominal :'),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  items: List.generate(
                                      spps.length,
                                      (index) => DropdownMenuItem(
                                          value: spps[index].id.toString(),
                                          child:
                                              Text('${spps[index].nominal}'))),
                                  onChanged: (val) {
                                    setState(() {
                                      sppsId = val.toString();
                                    });
                                  }),
                          SizedBox(height: 10),
                          // _isLoading
                          //     ? Center(
                          //   child: CircularProgressIndicator(),
                          // )
                          //     : TextField(
                          //   controller: tanggalBayar,
                          //   decoration: InputDecoration(
                          //     labelText: 'Input Date',
                          //     filled: true,
                          //     prefixIcon: Icon(Icons.calendar_today),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide.none
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.blue)
                          //     ),
                          //   ),
                          //   onTap: () {
                          //     _selectedDate();
                          //   },
                          // ),
                          SizedBox(height: 10),
                          MaterialButton(
                            color: Colors.grey,
                            child: const Text(
                              'Pick An Image',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            onPressed: () {
                              _pickImageFromGallery();
                            },
                          ),
                          _selectedImage != null
                              ? Image.file(_selectedImage!)
                              : Text(" "),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              final data = {
                                'user_id': user?.id.toString(),
                                'kelas_id': klsId.toString(),
                                'spp_id': sppsId.toString(),
                                // 'tanggal_bayar': tanggalBayar.toString(),
                                'bukti_pembayaran': _selectedImage != null
                                    ? _selectedImage!.path
                                    : null,
                                'status': 'unpaid',
                              };
                              // print("Data yang siap submit : ${jsonEncode(data)}");
                              // return;
                              // log(data.toString() as num);
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });

                                await HistoryService.createHistory(
                                    user_id: user!.id.toString(),
                                    kelas_id: klsId.toString(),
                                    spp_id: sppsId.toString(),
                                    // tanggal_bayar: tanggal_bayar.toString(),
                                    bukti_pembayaran: _selectedImage,
                                    status: 'unpaid');
                                // await OrderService.getOrders();

                                setState(() {
                                  _isLoading = false;
                                });
                                // super.initState();
                                if (!mounted) return;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const MyApp(
                                      i: 1,
                                    ),
                                  ),
                                );
                                nameSiswa.clear();
                                nisSiswa.clear();
                                jurusanSiswa.clear();
                                nominalSpp.clear();
                                // tanggalBayar.clear();
                                buktiPembayaran.clear();
                              } else {
                                // log('Nggak valid' as num);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.deepOrange),
                            ),
                            child: Text('Ask Payment'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
