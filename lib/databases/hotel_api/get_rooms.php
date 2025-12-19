<?php
// get_rooms.php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include 'db_connect.php';

// Ambil semua data kamar
$sql = "SELECT * FROM rooms";
$result = $connect->query($sql);

$rooms = array();

while ($row = $result->fetch_assoc()) {
    $rooms[] = $row;
}

// Kirim data list kamar ke Flutter
echo json_encode($rooms);
?>