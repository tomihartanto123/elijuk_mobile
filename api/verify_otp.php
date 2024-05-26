<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Mendapatkan email dan kode OTP dari body request
    $email = $_POST['email'];
    $otp = $_POST['otp'];

    // Verifikasi kode OTP dengan kode OTP yang disimpan di database
    // Jika cocok, kirim respon true, jika tidak, kirim respon false

    // Contoh sederhana, diasumsikan kode OTP yang disimpan adalah 1234
    if ($otp === '1234') {
        echo json_encode(['verified' => true]);
    } else {
        echo json_encode(['verified' => false]);
    }
} else {
    // Jika bukan metode POST, kirim respon status kode 405 Method Not Allowed
    http_response_code(405);
}
?>
