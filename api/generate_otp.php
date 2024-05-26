<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Mendapatkan email dari body request
    $email = $_POST['email'];

    // Generate kode OTP secara acak
    $otp = rand(1000, 9999);

    // Simpan kode OTP ke dalam database atau tempat penyimpanan lainnya

    // Kirim kode OTP ke email pengguna

    // Kirim respon ke aplikasi Flutter
    header('Content-Type: application/json');
    echo json_encode(['otp'. $otp]);
} else {
    // Jika bukan metode POST, kirim respon status kode 405 Method Not Allowed
    http_response_code(405);
}
?>
