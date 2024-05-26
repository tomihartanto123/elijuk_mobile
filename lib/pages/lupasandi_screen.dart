import 'dart:convert';
import 'package:d_method/d_method.dart';
import 'package:e_lijuk/pages/lupasandi_screen2.dart';
import 'package:e_lijuk/src/apiserver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LupaKataSandiOneScreen extends StatefulWidget {
  LupaKataSandiOneScreen({Key? key}) : super(key: key);

  @override
  _LupaKataSandiOneScreenState createState() => _LupaKataSandiOneScreenState();
}

class _LupaKataSandiOneScreenState extends State<LupaKataSandiOneScreen> {
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Lupa Kata Sandi',
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/img/img_untitled_2.png',
                width: 300,
                height: 300,
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: 50,
            child: Text(
              "Kode OTP",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
          ),
          Positioned(
            top: 330,
            left: 50,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                "Masukkan Email yang telah anda daftarkan",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.blueGrey[700],
                ),
              ),
            ),
          ),
          Positioned(
            top: 400,
            left: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Focus(
              onFocusChange: (hasFocus) {
                setState(() {});
              },
              child: TextFormField(
                controller: emailController,
                focusNode: emailFocusNode,
                autofillHints: [AutofillHints.email],
                decoration: InputDecoration(
                  hintText: "Gmail",
                  prefixIcon: Icon(
                    Icons.email,
                    color: emailFocusNode.hasFocus ? Colors.green : null,
                  ),
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
                  filled: true,
                  fillColor: Color(0xFFDADADA).withOpacity(0.5),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30.0,
            left: 0,
            right: 0,
            child: Align(
              alignment:
                  Alignment.bottomCenter, // Mengatur posisi ke bawah tengah
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 80, vertical: 19),
                child: ElevatedButton(
                  onPressed: () async {
                    final email = emailController.text;
                    // Get.to(LupaKataSandiTwoScreen(email: email, otp: '1111',));
                    DMethod.log('email : $email');
                    // return;
                    showLoading();
                    String otp = '';
                    if (email.isNotEmpty) {
                      try {
                        final response = await http.post(
                          ApiServer.urlApi('otp'),
                          body: {
                            'email': email,
                          },
                        );

                        DMethod.log('after response');

                        Get.back();
                        if (response.statusCode == 200) {
                          DMethod.log('otp berhasil');

                          // Dekode respons JSON
                          final responseData = json.decode(response.body);

                          // Periksa status pesan dari respons
                          if (responseData['status'] == 'success') {
                            // Login berhasil
                            otp = responseData['otp_code'];
                            Get.to(LupaKataSandiTwoScreen(email: email, otp: otp,));
                          } else {
                            // Login gagal
                            DMethod.log(
                                'otp gagal: ${responseData['message']}');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Login Gagal'),
                                  content: Text(responseData['message']),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } else {
                          DMethod.log('otp gagal');
                          // Tangani kesalahan jika ada
                          throw Exception(
                              'Gagal melakukan request: ${response.statusCode}');
                        }
                      } catch (error) {
                        DMethod.log('otp on error');
                        // Tangani kesalahan jaringan
                        throw Exception('Kesalahan jaringan: $error');
                      }
                    } else {
                      _scaffoldKey.currentState!.showSnackBar(
                        SnackBar(content: Text('Masukkan alamat email')),
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Kirim Kode OTP',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class APIService {
//   static Future<String> generateOTP(String email) async {
//     final url =
//         Uri.parse("http://172.16.106.76:8000//laravel10/mobile/otpcontroller.php");
//     final response = await http.post(url, body: {'email': email});
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       return data['otp_code'];
//     } else {
//       throw Exception('Gagal mengirimkan permintaan OTP');
//     }
//   }
// }
