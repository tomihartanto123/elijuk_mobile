// import 'dart:typed_data';
//
// import 'package:e_lijuk/pages/login.dart';
// import 'package:e_lijuk/widget/style.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
//
// class UbahProfil extends StatefulWidget {
//   const UbahProfil({Key? key}) : super(key: key);
//
//   @override
//   _UbahProfilState createState() => _UbahProfilState();
// }
//
// class _UbahProfilState extends State<UbahProfil> {
//   bool _obscureText = true;
//   Uint8List? _image;
//   File? imageSelected;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             color: Colors.white,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(
//                   'assets/img/Background.png',
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           toolbarHeight: 60,
//           title: Text(
//             'Ubah Profil',
//             style: GoogleFonts.dmSans(
//               fontSize: 23,
//               color: Colors.white,
//             ),
//           ),
//           backgroundColor: AppColor.hijau22,
//           centerTitle: true,
//         ),
//         body: Stack(
//           fit: StackFit.expand,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(
//                     'assets/img/Background.png',
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 30,
//               left: 0,
//               right: 0,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20.0,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Nama Pengguna",
//                       style: TextStyle(
//                         fontSize: 16,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: AppColor.abu1,
//                       ),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.person),
//                           hintText: 'Furijk_97',
//                           filled: true,
//                           fillColor: Colors.white.withOpacity(0.5),
//                           border: InputBorder.none,
//                         ),
//                         style: TextStyle(
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "Email",
//                       style: TextStyle(
//                         fontSize: 16,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: AppColor.abu1,
//                       ),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.email),
//                           hintText: 'example@example.com',
//                           filled: true,
//                           fillColor: Colors.white.withOpacity(0.5),
//                           border: InputBorder.none,
//                         ),
//                         style: TextStyle(
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     Center(
//                       child: Column(
//                         children: [
//                           SizedBox(height: 20),
//                           ElevatedButton(
//                             onPressed: () {
//                               // Your onPressed function here for left button
//                             },
//                             style: ElevatedButton.styleFrom(
//                               padding: EdgeInsets.symmetric(
//                                 vertical: 5,
//                                 horizontal: 60,
//                               ),
//                               backgroundColor: AppColor.hijau22,
//                               textStyle: TextStyle(
//                                 fontSize: 16,
//                               ),
//                       ),
//                             child: Text(
//                               'Simpan',
//                               style: TextStyle(color: Colors.white).copyWith(
//                                 fontSize: 16.0,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }