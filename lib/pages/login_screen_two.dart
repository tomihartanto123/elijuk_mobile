import 'dart:convert';
import 'package:e_lijuk/model/user_model_s.dart';
import 'package:e_lijuk/model/user_services.dart';
import 'package:e_lijuk/pages/lupasandi_screen.dart';
import 'package:e_lijuk/pages/lupasandi_screen3.dart';
import 'package:e_lijuk/src/apiserver.dart';
import 'package:http/http.dart' as http;
import 'package:d_method/d_method.dart';
import 'package:flutter/services.dart';
import 'package:e_lijuk/pages/beranda_screen.dart';
import 'package:e_lijuk/pages/test.dart';
import 'package:e_lijuk/pages/register_screen.dart';
import 'package:e_lijuk/widget/style.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String id_user = "";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final TextEditingController kataSandiController = TextEditingController();
  final TextEditingController namaPenggunaController = TextEditingController();

  static Future<void> loginUser(
      String username, String password, BuildContext context) async {
    DMethod.log('on login method');
    try {
      DMethod.log('username : $username');
      DMethod.log('password : $password');

      if (password.length < 8 || password.length > 16) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Gagal'),
              content: Text('Kata sandi 8-16 karakter'),
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
        return;
      }

      final response = await http.post(
        ApiServer.url('login.php'),
        body: {
          'nama_pengguna': username,
          'kata_sandi': password,
        },
      );

      DMethod.log('after response');

      if (response.statusCode == 200) {
        DMethod.log('login berhasil 2');

        // Decode JSON response
        final responseData = json.decode(response.body);

        // Check the status of the response
        if (responseData['status'] == 'success') {
          // Save response data to UserModel

          final userModel = UserModel.fromJson(responseData['data']);
          print("sini kaa?");

          await PasarAjaUserService.login(userModel);

          int idUser = await PasarAjaUserService.getUserId();
          // DMethod.log('id user : $idUser');

          // Successful login
          DMethod.log('login berhasil');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TestPage(
                initialIndex: 0,
              ), // Navigate to the desired page
            ),
          );
        } else {
          // Login failed
          DMethod.log('login gagal: ${responseData['message']}');
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
        DMethod.log('login gagal');
        // Handle error if any
        throw Exception('Gagal melakukan request: ${response.statusCode}');
      }
    } catch (error) {
      DMethod.log('on error : ${error.toString()}');
      // Handle network error
      throw Exception('Kesalahan jaringan: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false, // Tambahkan koma di sini
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background gambar
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Additional image on top
            Positioned(
              top: 120, // Adjust top position as needed
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'assets/img/taman.png',
                  width: 300, // Adjust width as needed
                  height: 300, // Adjust height as needed
                ),
              ),
            ),
            // Text widget
            Positioned(
              top: 70, // Adjust top position as needed
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Selamat Datang',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        'DMSans-Regular', // Adding the fontFamily property
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Form
            Positioned(
              top: 425, // Adjust top position as needed
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Pengguna",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'DMSans-Regular',
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors
                            .abu22, // Assuming this color is defined correctly
                      ),
                      child: TextField(
                        controller: namaPenggunaController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person), // Icon added here
                          hintText: 'Nama pengguna',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          border: InputBorder.none, // No border
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Kata Sandi",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'DMSans-Regular',
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors
                            .abu22, // Assuming this color is defined correctly
                      ),
                      child: TextField(
                        controller: kataSandiController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock), // Icon added here
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          hintText: 'Kata sandi',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          border: InputBorder.none, // No border
                        ),
                        obscureText: _obscureText,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight, // Align to the right
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LupaKataSandiOneScreen(), // Navigasi ke halaman pemulihan kata sandi
                            // builder: (context) =>
                            //       LupaKataSandiThreeScreen(
                            //         email: "tomihartanto72@gmail.com"), 
                            ),
                          );
                        },
                        child: Text(
                          "Lupa Kata Sandi?",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontFamily: 'DMSans-Italic',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.fontbutton,
                        ),
                        onPressed: () async {
                          try {
                            await loginUser(
                              namaPenggunaController.text,
                              kataSandiController.text,
                              context,
                            );
                          } catch (ex) {
                            print("ERROR : $ex");
                          }
                        },
                        child: Text(
                          "Masuk",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'DMSans-Regular',
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   width: double.infinity,
                    //   height: 50,
                    //   margin:
                    //       EdgeInsets.symmetric(horizontal: 40, vertical: 19),
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: AppColors.putih99,
                    //     ),
                    //     onPressed: () {
                    //       // Add your Google login logic here
                    //     },
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Image.asset(
                    //           "assets/icons/icon_google.png",
                    //         ), // Corrected icon usage
                    //         SizedBox(width: 10),
                    //         Text(
                    //           "Masuk dengan Google",
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //             color: AppColors.hitam,
                    //             fontFamily: 'DMSans-Regular',
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 10), // Moved SizedBox here
                    Row(
                      // Moved Row here
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Belum punya akun?",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.font00,
                            fontFamily: 'DMSans-Regular',
                          ),
                        ),
                        TextButton(
                          // Corrected TextButton here
                          onPressed: () {
                            print('Tombol ditekan!');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Daftar Disini',
                            style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'DMSans-Regular',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ], // Moved closing bracket here
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
