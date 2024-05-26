import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:e_lijuk/model/user_services.dart';
import 'package:e_lijuk/pages/login_screen_two.dart';
import 'package:e_lijuk/src/apiserver.dart';
import 'package:e_lijuk/widget/style.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _obscureText = true;
  Uint8List? _image;
  File? imageSelected;
  String? _profileImageUrl;

  String namaPengguna = "";
  String email = "";
  String password = "";

  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> updateUsername(
      int idUser, String newUsername, BuildContext context) async {
    try {
      final response = await http.post(
        ApiServer.url('edit_profile.php'),
        body: {
          'id_user': idUser.toString(),
          'nama_pengguna_baru': newUsername,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['message'] == 'Data berhasil diperbarui') {
          namaController.text = newUsername;
          setState(() {});
          _showSuccessDialog(context, responseData['message']);
        } else {
          _showErrorDialog(context, responseData['message']);
        }
      } else {
        _showErrorDialog(
            context, 'Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      _showErrorDialog(context, 'An error occurred: $error');
    }
  }

  Future<void> deleteFoto(String idUser) async {
    var uri = Uri.parse(
        '${ApiServer.urlGetImage}/api/delete_foto'); // Ganti dengan URL API Anda
    var response = await http.post(
      uri,
      body: {
        'id_user': idUser,
      },
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print('Success: ${responseData['message']}');
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> updateProfile(
      int idUser, String newUsername, BuildContext context) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${ApiServer.urlGetImage}/api/update_user"),
      );
      request.fields['id_user'] = idUser.toString();
      request.fields['nama_pengguna'] = newUsername;

      if (imageSelected != null) {
        request.files.add(
            await http.MultipartFile.fromPath('foto', imageSelected!.path));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseData = json.decode(await response.stream.bytesToString());

        if (responseData['message'] == 'Data berhasil diperbarui') {
          setState(() {
            namaController.text = newUsername;
            if (responseData['data']['foto'] != null) {
              _image =
                  null; // Reset local image if response contains a new image URL
              imageSelected = null;
            }
          });
          // print(responseData['message']['foto']);
          _showSuccessDialog(context, responseData['message']);

          setState(() {
            if (responseData['data']['foto'] != null) {
              _image =
                  null; // Clear the image file if a new image URL is provided
              _profileImageUrl =
                  responseData['data']['foto']; // Use the new image URL
            }
          });
          DMethod.log(responseData['data']['foto'].toString());
          await PasarAjaUserService.setUserData(
            PasarAjaUserService.photo,
            responseData['data']['foto'] == ""
                ? null
                : responseData['data']['foto'],
          );
        } else {
          _showErrorDialog(context, responseData['message']);
        }
      } else {
        _showErrorDialog(
            context, 'Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      _showErrorDialog(context, 'An error occurred: $error');
    }
  }

  static void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // showDetail();

    // print("Testing");
    // setState(() {
    //   showDetail();
    //   print("Testing2");
    // });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      String nama = await PasarAjaUserService.getUserData(
        PasarAjaUserService.fullName,
      );
      String email = await PasarAjaUserService.getUserData(
        PasarAjaUserService.email,
      );
      String sandi = await PasarAjaUserService.getUserData(
        PasarAjaUserService.sandi,
      );
      String urlFoto =
          await PasarAjaUserService.getUserData(PasarAjaUserService.photo);

      namaController.text = nama;
      emailController.text = email;
      passwordController.text = sandi;
      setState(() {
        _profileImageUrl = urlFoto != "" ? urlFoto : null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset:
            false, // Add this line to prevent the background from moving
        appBar: AppBar(
          toolbarHeight: 60,
          title: const Text(
            'Profil',
            style: TextStyle(
              fontFamily: 'DMSans-Regular',
              fontSize: 23,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.hijau100,
          centerTitle: true,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/img/background.png',
                  ), // Sesuaikan dengan path gambar yang benar
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Stack(
              children: [
                Positioned(
                  top: 30, // Sesuaikan dengan posisi vertikal yang diinginkan
                  left: 0, // Sesuaikan dengan posisi horizontal yang diinginkan
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: InkWell(
                        onTap: () {
                          _showSheet(context);
                        },
                        child: _image != null
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(_image!),
                              )
                            : _profileImageUrl != null
                                ? _profileImageUrl != ""
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "${ApiServer.urlGetImage}${_profileImageUrl!}"),
                                      )
                                    : const Material(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12.0),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.black,
                                          size: 50,
                                        ),
                                      )
                                : const Material(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                      size: 50,
                                    ),
                                  ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 200, // Adjust top position as needed
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nama Pengguna",
                      style: TextStyle(
                        fontFamily: 'DMSans-Regular',
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.abu22
                          // Change color to appropriate one
                          ),
                      child: TextField(
                        controller: namaController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          // Icon added here
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          border: InputBorder.none,
                          // Remove border
                        ),
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.abu22
                          // Change color to appropriate one
                          ),
                      child: TextField(
                        controller: emailController,
                        readOnly: true, // => hapus ini agar textfield bisa edit
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          // Change icon to appropriate one

                          // Change hint text to appropriate one
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          border: InputBorder.none,
                          // Remove border
                        ),
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Kata Sandi",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.abu22
                          // Change color to appropriate one
                          ),
                      child: TextField(
                        controller: passwordController,
                        readOnly: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          // Icon added here
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          border: InputBorder.none,
                          // Remove border
                        ),
                        obscureText: _obscureText,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              if (namaController.text.isEmpty ||
                                  namaController.text.length == 0) {
                                _showErrorDialog(
                                    context, "Harap masukan nama pengguna");
                                print("gagal");
                              } else {
                                int idUser =
                                    await PasarAjaUserService.getUserId();
                                DMethod.log('simpan');
                                await updateProfile(
                                  idUser,
                                  namaController.text,
                                  context,
                                );
                                await PasarAjaUserService.setUserData(
                                  PasarAjaUserService.fullName,
                                  namaController.text,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5, // Atur tinggi sesuai kebutuhan
                                horizontal: 60, // Atur lebar sesuai kebutuhan
                              ),
                              backgroundColor: AppColors
                                  .fontbutton, // Change to desired color
                              textStyle: const TextStyle(
                                fontSize: 16,
                              ), // Change to desired size
                            ),
                            child: Text(
                              'Simpan',
                              style:
                                  const TextStyle(color: Colors.white).copyWith(
                                fontSize: 16.0,
                              ),
                            ),
                          ),

                          const SizedBox(height: 5), // Spacer
                          ElevatedButton(
                            onPressed: () async {
                              await PasarAjaUserService.logout();
                              showLogoutConfirmationDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5, // Atur tinggi sesuai kebutuhan
                                horizontal: 60, // Atur lebar sesuai kebutuhan
                              ),
                              backgroundColor:
                                  AppColors.merah1, // Change to desired color
                              textStyle: const TextStyle(
                                fontSize: 16,
                              ), // Change to desired size
                            ),
                            child: Text(
                              'Keluar',
                              style:
                                  const TextStyle(color: Colors.white).copyWith(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
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

  Future<dynamic> _showSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () => _pickPhoto(ImageSource.camera),
                backgroundColor: Colors.black,
                heroTag: 'camera',
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 15),
              FloatingActionButton(
                onPressed: () => _pickPhoto(ImageSource.gallery),
                backgroundColor: Colors.purple,
                heroTag: 'galery',
                child: const Icon(
                  Icons.image_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 15),
              _profileImageUrl != null || _profileImageUrl == ""
                  ? FloatingActionButton(
                      onPressed: () async {
                        int idUser = await PasarAjaUserService.getUserId();
                        await deleteFoto(idUser.toString());
                        await PasarAjaUserService.setUserData(
                            PasarAjaUserService.photo, "");
                        setState(() {
                          _profileImageUrl = null;
                        });
                        Navigator.of(context).pop();
                      },
                      backgroundColor: Colors.blueGrey,
                      heroTag: 'delete',
                      child: const Icon(
                        Icons.delete_outlined,
                        color: Colors.white,
                      ),
                    )
                  : const Material(),
            ],
          ),
        );
      },
    );
  }

  Future _pickPhoto(ImageSource imageSource) async {
    // Logger().i('from photo');
    final returnImage = await ImagePicker().pickImage(source: imageSource);

    if (returnImage != null) {
      setState(() {
        imageSelected = File(returnImage.path);
        _image = File(returnImage.path).readAsBytesSync();
      });
    } else {
      return null;
    }

    Navigator.pop(context);
  }
}

void showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Keluar"),
        content: const Text("Apakah kamu yakin ingin keluar?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text(
              "Tidak",
              // style,
            ),
          ),
          TextButton(
            onPressed: () {
              // Perform logout action here
              Navigator.pushReplacement(
                // Use pushReplacement to prevent going back to the previous screen
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text("Iya"),
          ),
        ],
      );
    },
  );
}
