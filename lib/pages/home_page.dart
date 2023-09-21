import 'package:bayarspp_app/pages/payment_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                autoPlayInterval: Duration(seconds: 3),
                // enlargeCenterPage: true,
                aspectRatio: 2,
              ),
              items: [
                'https://idn.sch.id/wp-content/uploads/2019/12/WhatsApp-Image-2019-12-10-at-12.09.17.jpeg',
                'https://idn.sch.id/wp-content/uploads/2019/12/WhatsApp-Image-2019-12-10-at-12.09.17.jpeg',
                'https://idn.sch.id/wp-content/uploads/2019/12/WhatsApp-Image-2019-12-10-at-12.09.17.jpeg',
                'https://idn.sch.id/wp-content/uploads/2019/12/WhatsApp-Image-2019-12-10-at-12.09.17.jpeg',
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 4)),
                        child: Image.network(
                          i,
                          fit: BoxFit.cover,
                        ));
                  },
                );
              }).toList(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16,left: 16),
              alignment: Alignment.centerLeft,
              child: Text('Daftar Spp Tahun Pembelajaran 2023/2024', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16))),
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 16),
            child: Table(
              border: TableBorder.all(color: Colors.black),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                const TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Jurusan'),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Spp'),
                      ),
                    ),
                  ],
                ),
                const TableRow(
                  decoration: BoxDecoration(),
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('RPL'),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Rp. 250.000'),
                      ),
                    ),
                  ],
                ),
                const TableRow(
                  decoration: BoxDecoration(),
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('TKJ'),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Rp. 200.000'),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(),
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('DMM'),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Rp. 150.000'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange)
              ),
              child: Text('Bayar Sekarang'),
            ),
          ),
        ],
      ),
    );
  }
}
