import 'package:d_method/d_method.dart';
import 'package:e_lijuk/model/pemesanan_model.dart';
import 'package:e_lijuk/pages/jenis_paket.dart';
import 'package:e_lijuk/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class PemesananPage extends StatefulWidget {
  const PemesananPage({Key? key}) : super(key: key);

  @override
  State<PemesananPage> createState() => _PemesananPageState();
}

class _PemesananPageState extends State<PemesananPage> {
  FocusNode namaPemesanNode = FocusNode();
  TextEditingController namaPemesanCont = TextEditingController();
  FocusNode waNode = FocusNode();
  TextEditingController waCont = TextEditingController();
  FocusNode jenjangNode = FocusNode();
  TextEditingController jenjangCont = TextEditingController();
  FocusNode pesertaNode = FocusNode();
  TextEditingController pesertaCont = TextEditingController();
  FocusNode waktuNode = FocusNode();
  TextEditingController waktuCont = TextEditingController();
  FocusNode tanggalNode = FocusNode();
  TextEditingController tanggalCont = TextEditingController();

  String? selectedJenjang;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Pemesanan"),
        backgroundColor: AppColors.hijau100,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: const [],
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
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  top: 45, left: 15, right: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Nama Pemesan",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                  TextFormField(
                    controller: namaPemesanCont,
                    focusNode: namaPemesanNode,
                    decoration: InputDecoration(
                      hintText: "Nama",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFDADADA).withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "No. Whatsapp",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                  TextFormField(
                    controller: waCont,
                    focusNode: waNode,
                    keyboardType: TextInputType.number,
                    maxLength: 12,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    // untuk hilangkan inputan 0/12 aktfikan code dibawah
                    // buildCounter: (BuildContext context,
                    //     {int? currentLength, int? maxLength, bool? isFocused}) {
                    //   return null;
                    // },
                    decoration: InputDecoration(
                      hintText: "085812345678",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFDADADA).withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Jenis Pendidikan",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedJenjang,
                    hint: Text("Pilih Jenis Pendidikan"),
                    items: <String>['SMA/SMK', 'SMP/MTS', 'SD/MI', 'TK']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedJenjang = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFDADADA).withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Jumlah Peserta",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                  TextFormField(
                    controller: pesertaCont,
                    focusNode: pesertaNode,
                    maxLength: 2,
                    buildCounter: (BuildContext context,
                        {int? currentLength, int? maxLength, bool? isFocused}) {
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "25-50",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFDADADA).withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Waktu Pemesanan",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                  TextFormField(
                    readOnly: true, // Disable typing
                    decoration: InputDecoration(
                      hintText: 'Waktu Pemesanan',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFDADADA).withOpacity(0.5),
                    ),
                    controller: waktuCont,
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          waktuCont.text = pickedTime.format(context);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Tanggal Pemesanan",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                  TextFormField(
                    readOnly: true, // Disable typing
                    decoration: InputDecoration(
                      hintText: 'Tanggal Pemesanan',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFDADADA).withOpacity(0.5),
                    ),
                    controller: tanggalCont,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 1),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          tanggalCont.text =
                              "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  const Center(
                    child: Text(
                      'Keterangan : Pemesanan Pelatihan/Edukasi harus dilakukan 10 hari sebelum hari H dengan minimal pemesanan 25 dan maksimal 50 anggota',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: _buildPilihPaketButton(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPilihPaketButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero, // Remove button padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.green,
          ),
          onPressed: () {
            DMethod.log('nama pemesan : ${namaPemesanCont.text}');
            DMethod.log('no wa : ${waCont.text}');
            DMethod.log('jenis pendidikan : $selectedJenjang');
            DMethod.log('jumlah peserta : ${pesertaCont.text}');
            DMethod.log('waktu pemesanan : ${waktuCont.text}');
            DMethod.log('tanggal pemesanan : ${tanggalCont.text}');

            DateTime inputDate =
                DateFormat('dd-MM-yyyy').parseStrict(tanggalCont.text);
            DateTime today = DateTime.now();
            DateTime minDate = today.add(Duration(days: 10));

            if (namaPemesanCont.text.isEmpty ||
                waCont.text.isEmpty ||
                selectedJenjang.toString().isEmpty ||
                pesertaCont.text.isEmpty ||
                waktuCont.text.isEmpty ||
                tanggalCont.text.isEmpty) {
              const snackBar = SnackBar(
                content: Text('Harap isi semua data yang diperlukan'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (int.parse(pesertaCont.text) < 25 ||
                int.parse(pesertaCont.text) > 50) {
              const snackBar = SnackBar(
                content: Text(
                    'Harap diperhatikan bahwa peserta minimal 25 dan maximal 50'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              // Hapus kondisi dibawah jika tidak ingin batasan pemesanan harus tanggal H-10 sebelum hari G
            } else if (inputDate.isBefore(minDate)) {
              const snackBar = SnackBar(
                content:
                    Text('Harap tentukan tanggal H-10 dari pemesanan sekarang'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              var pesanan = PemesananModel(
                namaPengguna: namaPemesanCont.text,
                noWhatsapp: waCont.text,
                jenjangPendidikan: selectedJenjang!,
                jumlahPeserta: int.parse(pesertaCont.text),
                tanggalBooking: '2024-05-03',
                waktuAwal: waktuCont.text,
                waktuAkhir: waktuCont.text,
                tanggalPesan: tanggalCont.text,
              );
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: JenisPaketPage(pemesanan: pesanan),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.slideRight,
              );
            }
          },
          child: Text(
            "Pilih Paket",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'DMSans-Regular',
            ),
          ),
        ),
      ),
    );
  }
}
