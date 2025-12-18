import 'package:flutter/material.dart';

// ==========================================
// 1. MODEL (Bentuk Data Kamar yang Disimpan)
// ==========================================
class SavedRoom {
  final String id;
  final String name;
  final int price;
  final double rating;
  final String imageUrl;

  SavedRoom({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });
}

// ==========================================
// 2. SERVICE (Pengelola Data / Logic)
// ==========================================
class SavedRoomService extends ChangeNotifier {
  // --- SINGLETON PATTERN ---
  // Kode ini memastikan data tidak hilang saat pindah halaman
  static final SavedRoomService _instance = SavedRoomService._internal();
  
  factory SavedRoomService() {
    return _instance;
  }
  
  SavedRoomService._internal();
  // -------------------------

  // List untuk menampung kamar yang di-save
  final List<SavedRoom> _savedRooms = [];

  // --- FUNGSI-FUNGSI ---

  // 1. Ambil semua data saved rooms
  List<SavedRoom> getAllSavedRooms() {
    return _savedRooms;
  }

  // 2. Hitung jumlah saved rooms (untuk Profile)
  int getTotalSavedRooms() {
    return _savedRooms.length;
  }

  // 3. Cek apakah kamar tertentu sudah di-save? (untuk icon hati merah/putih)
  bool isRoomSaved(String roomId) {
    return _savedRooms.any((room) => room.id == roomId);
  }

  // 4. Tambah atau Hapus (Toggle)
  void toggleSave(SavedRoom room) {
    if (isRoomSaved(room.id)) {
      // Jika sudah ada, hapus
      _savedRooms.removeWhere((item) => item.id == room.id);
    } else {
      // Jika belum ada, tambahkan
      _savedRooms.add(room);
    }
    // PENTING: Memberitahu UI (Profile/SavedScreen) untuk refresh
    notifyListeners(); 
  }

  // 5. Hapus spesifik berdasarkan ID (Tombol hapus di halaman Saved)
  void removeRoom(String roomId) {
    _savedRooms.removeWhere((item) => item.id == roomId);
    notifyListeners();
  }
}