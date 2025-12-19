<?php
// db_connect.php
$host = "localhost";
$user = "root";      // User default XAMPP
$pass = "";          // Password default XAMPP (kosong)
$db   = "hotel_db";  // Nama database yang kamu buat tadi

$connect = new mysqli($host, $user, $pass, $db);

if ($connect->connect_error) {
    die("Koneksi Gagal: " . $connect->connect_error);
}

// Agar support karakter emoji/unik
$connect->set_charset("utf8");
?>