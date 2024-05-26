import 'package:d_method/d_method.dart';
import 'package:e_lijuk/pages/lupasandi_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_lijuk/widget/style.dart';
import 'package:e_lijuk/component/lupaks/code_text_field.dart';
import 'package:e_lijuk/component/lupaks/single_digit_code_text_field.dart';
import 'package:e_lijuk/component/lupaks/resend_button.dart';
import 'package:e_lijuk/component/lupaks/custom_elevated_button.dart';
import 'package:e_lijuk/pages/lupasandi_screen3.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LupaKataSandiTwoScreen extends StatefulWidget {
  @override
  State<LupaKataSandiTwoScreen> createState() => _LupaKataSandiTwoScreenState();

  final String email;
  final String otp;

  const LupaKataSandiTwoScreen({
    required this.otp,
    required this.email,
  });
}

class _LupaKataSandiTwoScreenState extends State<LupaKataSandiTwoScreen> {
  final TextEditingController firstDigitController = TextEditingController();

  final TextEditingController secondDigitController = TextEditingController();

  final TextEditingController thirdDigitController = TextEditingController();

  final TextEditingController fourthDigitController = TextEditingController();

  final FocusNode firstFocusNode = FocusNode();

  final FocusNode secondFocusNode = FocusNode();

  final FocusNode thirdFocusNode = FocusNode();

  final FocusNode fourthFocusNode = FocusNode();

  late String otpCode;

  @override
  void initState() {
    super.initState();
    DMethod.log("KODE OTP : ${widget.otp}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 60,
        centerTitle: true,
        title: Text(
          'Lupa Kata Sandi',
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
          ),
        ),
      ),
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
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 27.0, right: 29.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SingleDigitCodeTextField(
                            controller: firstDigitController,
                            nextFocusNode: secondFocusNode),
                        SingleDigitCodeTextField(
                            controller: secondDigitController,
                            nextFocusNode: thirdFocusNode),
                        SingleDigitCodeTextField(
                            controller: thirdDigitController,
                            nextFocusNode: fourthFocusNode),
                        SingleDigitCodeTextField(
                            controller: fourthDigitController,
                            nextFocusNode: fourthFocusNode),
                      ],
                    ),
                  ),
                  SizedBox(height: 34.0),
                  GestureDetector(
                    onTap: () {
                      // Tambahkan logika untuk mengirim ulang kode OTP di sini
                      // Contoh:
                      print(
                          "Kirim ulang kode OTP"); // Tambahkan aksi yang sesuai di sini
                    },
                    child: Column(
                      children: [
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Anda belum menerima kode OTP? ",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.font00,
                                fontFamily: 'DMSans-Regular',
                              ),
                            ),
                            Text(
                              "Kirim ulang",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.blue01,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.blue01),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 212)
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.fontbutton,
                  ),
                  onPressed: () {
                    DMethod.log('test button');
                    String otpInput =
                        "${firstDigitController.text}${secondDigitController.text}${thirdDigitController.text}${fourthDigitController.text}";
                    DMethod.log('otp input : $otpInput');
                    DMethod.log('otp asli : ${widget.otp}');

                    if (otpInput != widget.otp) {
                      Get.showSnackbar(
                        GetSnackBar(
                          title: 'Peringatan',
                          message: 'Kode Otp tidak cocok',
                          duration: Duration(seconds: 3),
                        ),
                      );
                    } else {
                      Get.to(LupaKataSandiThreeScreen(email: widget.email,));
                    }
                  },
                  child: Text(
                    "Lanjut",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'DMSans-Regular',
                    ),
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
