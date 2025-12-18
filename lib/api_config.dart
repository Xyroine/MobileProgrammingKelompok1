class ApiConfig {
  // Ganti URL ini sesuai perangkat yang kamu pakai:
  
  // OPSI 1: Untuk Android Emulator (Paling umum)
  static const String baseUrl = "http://10.0.2.2/hotel_api";
  
  // OPSI 2: Untuk HP Asli (Ganti X dengan angka IP laptopmu)
  // static const String baseUrl = "http://192.168.1.X/hotel_api"; 
  
  // Endpoint (Alamat spesifik)
  static const String login = "$baseUrl/login.php";
  static const String getRooms = "$baseUrl/get_rooms.php";
}