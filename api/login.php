<?php
// Sambungkan ke database
require_once 'koneksi.php';

// Mendapatkan data dari request
$data = json_decode(file_get_contents("php://input"));
if (isset($data->username) && isset($data->password)) {
    $username = $data->username;
    $password = $data->password;

    // Sambungkan ke database menggunakan koneksi yang sudah disediakan
    $conn = mysqli_connect($server, $user, $pass, $database);

    // Periksa koneksi
    if (!$conn) {
        $response = array("status" => "error", "message" => "Koneksi ke database gagal: " . mysqli_connect_error());
        echo json_encode($response);
    } else {
        // Lakukan query untuk memeriksa keberadaan username dan password
        $query = "SELECT * FROM user_akun WHERE username = '$username' AND password = '$password'";
        $result = mysqli_query($conn, $query);

        if (mysqli_num_rows($result) > 0) {
            // Jika data ditemukan, kirimkan respons berhasil
            $response = array("status" => "success", "message" => "Login berhasil");
            echo json_encode($response);
        } else {
            // Jika data tidak ditemukan, kirimkan respons gagal
            $response = array("status" => "error", "message" => "Email atau password salah");
            echo json_encode($response);
        }

        // Tutup koneksi ke database
        mysqli_close($conn);
    }
} else {
    // Jika data username dan password tidak tersedia, kirimkan respons gagal
    $response = array("status" => "error", "message" => "username dan password harus disediakan");
    echo json_encode($response);
}