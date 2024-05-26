import 'package:d_method/d_method.dart';
import 'package:e_lijuk/model/pemesanan_model.dart';
import 'package:e_lijuk/pages/pesanan_success.dart';
import 'package:e_lijuk/pages/test.dart';
import 'package:e_lijuk/src/apiserver.dart';
import 'package:e_lijuk/widget/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class RiwayatPemesanan extends StatefulWidget {
  const RiwayatPemesanan({Key? key}) : super(key: key);

  @override
  _RiwayatPemesananState createState() => _RiwayatPemesananState();
}

class _RiwayatPemesananState extends State<RiwayatPemesanan> {
  late List<PemesananModel> riwayatList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchDataPemesanan();
    });
  }

  Future<void> fetchDataPemesanan() async {
    final response = await http.get(ApiServer.urlPublic('list_riwayat.php'));

    if (response.statusCode == 200) {
      List<dynamic> dataJson = json.decode(response.body);
      setState(() {
        riwayatList =
            dataJson.map((json) => PemesananModel.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: Text(
            'Riwayat Pemesanan',
            style: TextStyle(
              fontFamily: 'DMSans-Regular',
              fontSize: 23,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.hijau100,
          centerTitle: true,
        ),
        body: Container(
          child: RefreshIndicator(
            onRefresh: fetchDataPemesanan,
            child: riwayatList.length != 0
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 0, left: 0, right: 0),
                    itemCount: riwayatList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          // Navigasi ke halaman detail riwayat dengan mengirim data riwayat yang dipilih
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailRiwayat(riwayat: riwayatList[index]),
                            ),
                          );
                          // Handle result jika diperlukan
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 0),
                          color: Colors.white,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 13, vertical: 5),
                            leading: CircleAvatar(
                              backgroundColor: riwayatList[index].status ==
                                      'diproses'
                                  ? Colors.yellow
                                  : riwayatList[index].status == 'diterima'
                                      ? Colors.green
                                      : riwayatList[index].status == 'ditolak'
                                          ? Colors.red
                                          : Colors.grey,
                              child: Icon(
                                riwayatList[index].status == 'diproses'
                                    ? Icons.timer
                                    : riwayatList[index].status == 'diterima'
                                        ? Icons.check_circle
                                        : riwayatList[index].status == 'ditolak'
                                            ? Icons.cancel
                                            : Icons.error_outline,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              'Nama Pemesan: ${riwayatList[index].namaPengguna}',
                              style: TextStyle(
                                fontFamily: 'DMSans-Regular',
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Status: ${riwayatList[index].status}',
                                  style: TextStyle(
                                    fontFamily: 'DMSans-Regular',
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Paket: ${riwayatList[index].jenis_paket}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black54,
                                  ),
                                ),
                                Divider()
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.doc_text_search),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Belum Terdapat Riwayat Pesanan"),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class DetailRiwayat extends StatefulWidget {
  final PemesananModel riwayat;

  const DetailRiwayat({Key? key, required this.riwayat}) : super(key: key);

  @override
  State<DetailRiwayat> createState() => _DetailRiwayatState();
}

class _DetailRiwayatState extends State<DetailRiwayat> {
  Future<void> _deleteData() async {
    try {
      DMethod.log('id pemesanan : ${widget.riwayat.idPemesanan}');
      final response = await http.get(ApiServer.url(
          'batalkan_pesanan.php?id=${widget.riwayat.idPemesanan}'));

      if (response.statusCode == 200) {
        DMethod.log('Order canceled successfully!');
        // _showSuccessDialog(context);
      } else {
        DMethod.log('Failed to cancel order: ${response.statusCode}');
        _showFailureDialog(context, response.statusCode);
      }
    } catch (error) {
      DMethod.log('Error: $error');
      _showUnexpectedErrorDialog(context);
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Order canceled successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              // Get.back();
              // Get.back();
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: TestPage(
                  initialIndex: 1,
                ),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showKonfirmasi(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Yakin ingin membatalkan pesanan?'),
        actions: [
          TextButton(
            onPressed: () async {
              // Get.back();
              // Get.back();
              await _deleteData();
              _showSuccessDialog(context);
            },
            child: Text('Yakin'),
          ),
          TextButton(
            onPressed: () {
              // Get.back();
              // Get.back();
              Get.back();
            },
            child: Text('Batal'),
          ),
        ],
      ),
    );
  }

  void _showFailureDialog(BuildContext context, int statusCode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Failed to Cancel Order'),
        content: Text('Error code: $statusCode'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showUnexpectedErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('An unexpected error occurred.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            leading: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            toolbarHeight: 100,
            title: Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                'Detail Riwayat',
                style: TextStyle(
                  fontFamily: 'DMSans-Regular',
                  fontSize: 23,
                  color: Colors.white,
                ),
              ),
            ),
            backgroundColor: Colors.green,
            centerTitle: true,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar
                Container(
                  height: 250, // Ubah tinggi kotak gambar sesuai kebutuhan
                  width: double.infinity,
                  child: Image.asset(
                    'assets/img/taman.png',
                    fit: BoxFit.cover, // Menyesuaikan gambar ke dalam kotak
                  ),
                ),
                SizedBox(height: 20), // Spasi antara gambar dan teks
                // Informasi pemesanan
                Text(
                  'Nama Pemesan: ${widget.riwayat.namaPengguna}',
                  style: TextStyle(
                    fontFamily: 'DMSans-Regular',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Nomor Telepon: ${widget.riwayat.noWhatsapp}',
                  style: TextStyle(
                    fontFamily: 'DMSans-Regular',
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Tanggal Pemesanan: ${widget.riwayat.tanggalBooking}',
                  style: TextStyle(
                    fontFamily: 'DMSans-Regular',
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Waktu Pemesanan: ${widget.riwayat.waktuAwal}',
                  style: TextStyle(
                    fontFamily: 'DMSans-Regular',
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Status: ${widget.riwayat.status}',
                  style: TextStyle(
                    fontFamily: 'DMSans-Regular',
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 10),
                Text(
                  'Total Pemesanan: ${widget.riwayat.jumlahPeserta}',
                  style: TextStyle(
                    fontFamily: 'DMSans-Regular',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: getStatusPesan(widget.riwayat.status!),
      ),
    );
  }

  Widget getStatusPesan(String status) {
    if (status == 'diterima') {
      return Padding(
        padding: EdgeInsets.all(35),
        child: Container(
          width: 10,
          height: 10,
        ),
      );
    } else if (status == "ditolak") {
      return Padding(
        padding: const EdgeInsets.all(35.0),
        child: ElevatedButton(
          onPressed: () async {
            await _deleteData();
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const TestPage(
                initialIndex: 2,
              ),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: 1,
              horizontal: 30,
            ),
            backgroundColor: Colors.red,
            textStyle: TextStyle(
              fontSize: 20,
            ),
          ),
          child: Text(
            'Hapus dan ajukan ulang',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(35.0),
        child: ElevatedButton(
          onPressed: () {
            _showKonfirmasi(context);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: 1,
              horizontal: 30,
            ),
            backgroundColor: Colors.red,
            textStyle: TextStyle(
              fontSize: 20,
            ),
          ),
          child: Text(
            'Batalkan Pemesanan',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}
