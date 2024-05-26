// import 'package:e_lijuk/pages/login_screen.dart';

import 'package:e_lijuk/pages/login_screen_two.dart';
import 'package:e_lijuk/src/apiserver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController namaPenggunaController = TextEditingController();
  final TextEditingController kataSandiController = TextEditingController();
  final TextEditingController konfirmasiKataSandiController =
      TextEditingController();
  double _imageHeight = 300.0; // Tinggi awal gambar
  double _imageTop = 10.0; // Posisi awal gambar
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {

      if(kataSandiController.text.length < 8 || kataSandiController.text.length > 16){
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
   

    if (kataSandiController.text != konfirmasiKataSandiController.text) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Kata sandi tidak cocok'),
            content: Text(''),
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

    try {
      // final String apiUrl = 'http://192.168.53.207/laravel10/mobile/';
      final response = await http.post(ApiServer.url('register.php'), body: {
        'nama_pengguna': namaPenggunaController.text,
        'email': emailController.text,
        'kata_sandi': kataSandiController.text,
        'konfirmasi_kata_sandi': konfirmasiKataSandiController.text,
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          // Navigasi ke halaman setelah pendaftaran berhasil
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Pendaftaran Berhasil'),
                content: Text(responseData['message']),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Tampilkan pesan kesalahan jika pendaftaran gagal
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Pendaftaran Gagal'),
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
        // Tampilkan pesan kesalahan jika koneksi gagal
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Kesalahan'),
              content: Text('Gagal terhubung ke server'),
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
    } catch (ex) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pendaftaran Gagal 222'),
            content: Text(''),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Ubah warna sesuai kebutuhan
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 60, // Tinggi toolbar
        centerTitle: true, // Teks judul akan ditengah
        title: Text(
          'Buat Akun',
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
          ),
        ),
      ),
      resizeToAvoidBottomInset: null,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            setState(() {
              _imageHeight = 300.0 - _scrollController.offset * 0.5;
              _imageTop = 10.0 -
                  _scrollController.offset *
                      0.5; // Atur posisi gambar sesuai dengan scroll
            });
          }
          return true;
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/backround.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: _imageTop, // Atur posisi gambar sesuai dengan scroll
              left: (MediaQuery.of(context).size.width - 260) / 2,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: 260,
                height: _imageHeight,
                child: Image.asset('assets/img/Register.png'),
              ),
            ),
            SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 300, 20, 0),
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
                        color: Colors.grey[200],
                      ),
                      child: TextField(
                        controller: namaPenggunaController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Nama',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]+')),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Gmail",
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
                        color: Colors.grey[200],
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: '@gmail.com',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          border: InputBorder.none,
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
                        color: Colors.grey[200],
                      ),
                      child: TextField(
                        controller: kataSandiController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureTextPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureTextPassword = !_obscureTextPassword;
                              });
                            },
                          ),
                          hintText: 'Kata sandi',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          border: InputBorder.none,
                        ),
                        obscureText: _obscureTextPassword,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLength: 8, // Menambahkan batasan maksimal 8 karakter
                        maxLengthEnforcement: MaxLengthEnforcement
                            .none, // Menghilangkan garis bawah
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Konfirmasi Kata Sandi",
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
                        color: Colors.grey[200],
                      ),
                      child: TextField(
                        controller: konfirmasiKataSandiController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureTextConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureTextConfirmPassword =
                                    !_obscureTextConfirmPassword;
                              });
                            },
                          ),
                          hintText: 'Konfirmasi Kata Sandi',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          border: InputBorder.none,
                        ),
                        obscureText: _obscureTextConfirmPassword,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: registerUser,
                        child: Text(
                          "Daftar",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'DMSans-Regular',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
