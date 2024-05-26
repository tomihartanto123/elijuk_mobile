// import 'package:e_lijuk/pages/login_screen.dart';
import 'package:e_lijuk/pages/login_screen_two.dart';
import 'package:e_lijuk/src/apiserver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LupaKataSandiThreeScreen extends StatefulWidget {
  LupaKataSandiThreeScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  _LupaKataSandiThreeScreenState createState() =>
      _LupaKataSandiThreeScreenState();
}

class _LupaKataSandiThreeScreenState extends State<LupaKataSandiThreeScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController kataSandiController = TextEditingController();
  final TextEditingController konfirmasiKataSandiController =
      TextEditingController();
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  void goToLogin() {
    // Fungsi untuk berpindah ke halaman login
    Navigator.pushReplacementNamed(
        context, '/login'); // Ganti '/login' dengan rute login yang sebenarnya
  }

  showLoading({
    bool canPop = false,
    Color loadingColor = Colors.green,
  }) {
    Get.dialog(
      PopScope(
        canPop: canPop,
        child: Center(
          child: CircularProgressIndicator(
            color: loadingColor,
          ),
        ),
      ),
      barrierDismissible: true,
      transitionCurve: Curves.easeOut,
    );
  }

  Future<void> updatePassword(String email, String newPassword) async {
    try {
      showLoading();
      // Kirim permintaan POST ke server dengan data email dan password baru
      var response = await http.post(
        ApiServer.url('sandibaru.php'),
        body: {
          'email': email,
          'password': newPassword,
        },
      );

      Get.back();

      // Periksa kode status respons
      if (response.statusCode == 200) {
        Get.to(LoginScreen());
      } else {
        // Gagal: Tampilkan pesan kesalahan
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani kesalahan jaringan
      print('Error: $e');
    }
  }

  void showHidePassword(bool isShow) {
    setState(() {
      if (isShow) {
        isShow = false;
      } else {
        isShow = true;
      }
    });
  }

  // Metode untuk menyimpan kata sandi baru
  // void saveNewPassword() async {
  //   // Lakukan pembaruan kata sandi di backend
  //   final String apiUrl = 'http://192.168.1.9/laravel10/mobile/sandibaru.php';
  //   final response = await http.post(Uri.parse(apiUrl), body: {
  //     'email': emailController.text,
  //     'kata_sandi_baru': kataSandiController.text,
  //     'konfirmasi_kata_sandi_baru': konfirmasiKataSandiController.text,
  //   });
  //
  //   if (response.statusCode == 200) {
  //     // Jika pembaruan berhasil, kembali ke halaman login
  //     goToLogin();
  //   } else {
  //     // Jika pembaruan gagal, tampilkan pesan kesalahan
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('Gagal menyimpan kata sandi baru.'),
  //       backgroundColor: Colors.red,
  //     ));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        // Ubah warna sesuai kebutuhan
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 60,
        // Tinggi toolbar
        centerTitle: true,
        // Teks judul akan ditengah
        title: Text(
          'Lupa Kata Sandi',
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false, // Tambahkan baris ini
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/background.png'),
                // Perbaiki path gambar
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Additional image on top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/img/img_untitled_2.png', // Perbaiki path gambar
                width: 300,
                height: 300,
              ),
            ),
          ),
          // Text widgets
          Positioned(
            top: 300,
            left: 50,
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.8, // 80% of screen width
              child: Text(
                "Kata Sandi Baru",
                maxLines: 2,
                overflow:
                    TextOverflow.ellipsis, // Add ellipsis if text overflows
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey[700],
                ),
              ),
            ),
          ),
          // Password text field
          Positioned(
            top: 330,
            left: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              controller: kataSandiController, //Tambahkan controller
              obscureText: _obscureTextPassword, // Agar karakter tidak terlihat
              decoration: InputDecoration(
                hintText: 'Masukkan Sandi Baru',
                filled: true,
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(_obscureTextPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      if (_obscureTextPassword) {
                        _obscureTextPassword = false;
                      } else {
                        _obscureTextPassword = true;
                      }
                    });
                  },
                ),
                fillColor: Color(0xFFDADADA).withOpacity(0.5),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
          ),
          // Confirmation text
          Positioned(
            top: 400,
            left: 50,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                "Konfirmasi Kata Sandi Baru",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey[700],
                ),
              ),
            ),
          ),
          // Confirmation text field
          Positioned(
            top: 430,
            left: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              controller: konfirmasiKataSandiController, //Tambahkan controller
              obscureText:
                  _obscureTextConfirmPassword, // Agar karakter tidak terlihat
              decoration: InputDecoration(
                hintText: 'Masukkan Konfirmasi Kata Sandi Baru',
                filled: true,
                fillColor: Color(0xFFDADADA).withOpacity(0.5),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        if (_obscureTextConfirmPassword) {
                          _obscureTextConfirmPassword = false;
                        } else {
                          _obscureTextConfirmPassword = true;
                        }
                      });
                    },
                    icon: Icon(_obscureTextConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off)),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
          ),
          // Save button
          Positioned(
            top: 600, // Posisikan lebih dekat dengan form
            left: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.8,
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () async {
                  if (kataSandiController.text ==
                      konfirmasiKataSandiController.text) {
                    await updatePassword(
                      widget.email,
                      kataSandiController.text,
                    );
                  } else {
                    const snackBar = SnackBar(
                      content: Text('Kata sandi tidak cocok'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text(
                  "Simpan",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'DMSans-Regular',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
