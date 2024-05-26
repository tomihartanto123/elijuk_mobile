// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:e_lijuk/model/paket_model.dart';
import 'package:e_lijuk/model/pemesanan_model.dart';
import 'package:e_lijuk/pages/pesanan_success.dart';
import 'package:e_lijuk/src/apiserver.dart';
import 'package:e_lijuk/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class JenisPaketPage extends StatefulWidget {
  const JenisPaketPage({
    Key? key,
    required this.pemesanan,
  }) : super(key: key);

  final PemesananModel pemesanan;

  @override
  State<JenisPaketPage> createState() => _JenisPaketPageState();
}

class _JenisPaketPageState extends State<JenisPaketPage> {
  var borderSide = const BorderSide(width: 1, color: Colors.black);

  // controller untuk data paket
  Future<List<PaketModel>> getAllPaket() async {
    final response = await http.get(ApiServer.urlPublic('list_paket.php'));

    if (response.statusCode == 200) {
      DMethod.log('response is 200');
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => PaketModel.fromJson(data)).toList();
    } else {
      DMethod.log('failure to fetch paket');
      throw Exception('Failed to fetch paket data');
    }
  }

  Future<void> insertPemesanan(
    String idPaket,
    PemesananModel pesan,
  ) async {
    // Show loading dialog
    Get.dialog(
      const PopScope(
        canPop: true,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      ),
      barrierDismissible: true,
      transitionCurve: Curves.easeOut,
    );

    // Prepare request URL and body
    final Map<String, dynamic> requestBody = {
      'id_paket': idPaket,
      'nama_pengguna': pesan.namaPengguna,
      'no_whatsapp': pesan.noWhatsapp,
      'jenjang_pendidikan': pesan.jenjangPendidikan,
      'jumlah_peserta': pesan.jumlahPeserta,
      'tanggal_booking': pesan.tanggalBooking,
      'waktu_awal': pesan.waktuAwal,
      'waktu_akhir': pesan.waktuAkhir,
      'tanggal_pesan': pesan.tanggalPesan,
    };

    // Send HTTP POST request
    final response = await http.post(
      ApiServer.urlPublic('add_pemesanan.php'),
      body: jsonEncode(requestBody),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    // Close loading dialog
    Get.back();

    // Check response status code
    if (response.statusCode == 200) {
      // Parse JSON response
      DMethod.log('response body : ${response.body}');
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      if (responseData['status'] == 'success') {
        // Show success dialog
        Get.dialog(
          AlertDialog(
            title: const Text('Success'),
            content: const Text('Pesanan berhasil dibuat.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Get.off(
                    const PesananSuccess(),
                    transition: Transition.downToUp,
                    duration: const Duration(milliseconds: 500),
                  );
                },
              ),
            ],
          ),
        );
      } else {
        // Show error dialog with response message
        Get.dialog(
          AlertDialog(
            title: const Text('Peringatan'),
            content: Text(responseData['message'] ?? 'Pesanan gagal dibuat.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      }
    } else {
      // Show HTTP error dialog
      Get.dialog(
        AlertDialog(
          title: const Text('Peringatan'),
          content: Text('Pesanan gagal dibuat: ${response.reasonPhrase}'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jenis Paket"),
        backgroundColor: AppColors.hijau100,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: const [],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/backround.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 45,
            left: 0,
            right: 0,
            child: FutureBuilder<List<PaketModel>>(
              future: getAllPaket(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  final paketList = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 50,
                      child: ListView.builder(
                        itemCount: paketList.length,
                        itemBuilder: (context, index) {
                          final paket = paketList[index];
                          return _buildItem(paket);
                        },
                      ),
                    ),
                  );
                }

                return const Text('data gagal didpatka');
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildItem(PaketModel paket) {
    return InkWell(
      onTap: () async {
        await insertPemesanan(paket.idPaket!, widget.pemesanan);
      },
      child: Container(
        // height: 160,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            top: borderSide,
            bottom: borderSide,
            right: borderSide,
            left: borderSide,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
                border: Border(
                  bottom: borderSide,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    paket.jenisPaket ?? 'null',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.9,
                  height: 105,
                  child: Image.asset('assets/img/paket-1.png'),
                ),
                // const SizedBox(width: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(paket.deskripsi ?? 'null'),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text("Biaya : Rp. ${paket.biaya}"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 100,
                //   child: Align(
                //     alignment: Alignment.bottomCenter,
                //     child: Text("Biaya : Rp. ${paket.biaya}"),
                //   ),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
