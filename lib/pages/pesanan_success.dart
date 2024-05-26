import 'package:e_lijuk/pages/riwayat_screen.dart';
import 'package:e_lijuk/pages/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class PesananSuccess extends StatefulWidget {
  const PesananSuccess({Key? key}) : super(key: key);

  @override
  State<PesananSuccess> createState() => _PesananSuccessState();
}

class _PesananSuccessState extends State<PesananSuccess> {
  @override
  void initState() {
    super.initState();
    _navigateToSatuAfterDelay();
  }

  Future<void> _navigateToSatuAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3)); // Tunggu 3 detik
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: TestPage(
        initialIndex: 1,
      ),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
    // Get.to(RiwayatPemesanan());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/pesanan-success.png',
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 50),
            const Text(
              'Berhasil !!',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                'Anda Berhasil Booking Tunggu Konfirmasi Selanjutnya!!!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
