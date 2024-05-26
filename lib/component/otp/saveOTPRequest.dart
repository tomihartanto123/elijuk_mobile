import 'package:http/http.dart' as http;

void saveOTPRequest(String email, String otpCode) async {
  // URL ke file koneksi.php di server
  Uri url = Uri.parse("http://example.com/path/to/koneksi.php");

  // Buat request HTTP
  var response = await http.post(url, body: {
    'email': email,
    'otp_code': otpCode,
  });

  // Cek jika request berhasil
  if (response.statusCode == 200) {
    print("Email dan kode OTP berhasil disimpan.");
  } else {
    print("Gagal menyimpan email dan kode OTP.");
  }
}
