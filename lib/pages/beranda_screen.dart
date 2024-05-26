import 'package:e_lijuk/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:e_lijuk/pages/test.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85), // Set preferred height for the AppBar
        child: AppBar(
          backgroundColor: AppColors.hijau100, // Tambahkan warna latar belakang
          toolbarHeight: 80, // Tinggi toolbar
          centerTitle: false, // Teks judul akan ditengah
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0), // Add SizedBox to move the text upwards
              Text(
                'Selamat Datang',
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                  fontFamily: 'DMSans-Regular'
                ),
              ),
              SizedBox(height: 8), // Spacer
              // Text(
              //   'Rima',
              //   style: TextStyle(
              //     fontSize: 25,
              //     fontFamily: 'DMSans-Regular',
              //     color: AppColors.putih99, // Adjust color as needed
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/backround.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 45, // Adjust this position as needed
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildHeader(),
                  _buildInformasiTaman(
                    namaTaman: 'Taman DLH',
                    lokasiTaman: 'Jl. Dr. Soetomo No.10',
                    deskripsiTaman:
                        'Taman yang terletak di pusat kota Nganjuk ini memiliki berbagai fasilitas seperti taman bermain anak, area olahraga, dan taman bunga.',
                    gambarTaman: 'taman_dlh.jpg',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
  return Container(
    padding: EdgeInsets.fromLTRB(30, 0, 40, 10), // Adjust padding to move the text upwards and to the left
    alignment: Alignment.centerLeft, // Align the text to the left
    child: Text(
      'Informasi Terkini',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'DMSans-Regular'
      ),
    ),
  );
}


  Widget _buildInformasiTaman({
    required String namaTaman,
    required String lokasiTaman,
    required String deskripsiTaman,
    required String gambarTaman,
  }) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/img/tamandlh.jpg',
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            namaTaman,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            lokasiTaman,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Text(
            deskripsiTaman,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
