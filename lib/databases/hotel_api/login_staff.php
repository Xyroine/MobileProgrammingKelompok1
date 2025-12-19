<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Sesuaikan dengan database Anda
$conn = new mysqli("localhost", "root", "", "hotel_db");

$email = $_POST['email'];
$password = $_POST['password'];

// ✅ UBAH DISINI:
// Kita cek tabel 'users', tapi pastikan role-nya adalah 'staff'
$sql = "SELECT * FROM users WHERE email = '$email' AND password = '$password' AND role = 'staff'";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Ambil data user untuk dikirim balik ke Flutter (opsional, buat simpan session nanti)
    $row = $result->fetch_assoc();
    echo json_encode(array(
        "status" => "success", 
        "message" => "Login Staff Berhasil",
        "data" => $row
    ));
} else {
    echo json_encode(array("status" => "error", "message" => "Email/Password salah atau Anda bukan Staff"));
}
?>