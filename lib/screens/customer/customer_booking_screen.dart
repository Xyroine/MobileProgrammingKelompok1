import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'customer_available_room_screen.dart';

class CustomerBookingScreen extends StatefulWidget {
  const CustomerBookingScreen({super.key});

  @override
  State<CustomerBookingScreen> createState() => _CustomerBookingScreenState();
}

class _CustomerBookingScreenState extends State<CustomerBookingScreen> {
  DateTime _checkInDate = DateTime(2025, 12, 17);
  DateTime _checkOutDate = DateTime(2025, 12, 20);
  int _guests = 4;
  bool _showCalendar = false;
  bool _isSelectingCheckIn = true;

  // Method untuk handle navigation
  void _onNavigationTap(int index) {
    if (index == 0) {
      // Index 0 = Home, kembali ke home
      Navigator.pop(context);
    } else if (index == 1) {
      // Index 1 = Search/Booking, sudah di halaman ini
      // Tidak perlu melakukan apa-apa
    } else {
      // Untuk index lain, Anda bisa tambahkan navigasi ke screen lain
      // Sementara kita pop dulu untuk kembali
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final nights = _checkOutDate.difference(_checkInDate).inDays;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    style: IconButton.styleFrom(backgroundColor: AppTheme.cardBackground),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Book Your Stay', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text('Select dates and guests', style: TextStyle(fontSize: 14, color: AppTheme.textGray)),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Check-in Date', style: TextStyle(fontSize: 12, color: AppTheme.textGray)),
                    const SizedBox(height: 8),
                    _DateCard(
                      date: _checkInDate,
                      color: AppTheme.emeraldGreen,
                      onTap: () => setState(() {
                        _showCalendar = !_showCalendar;
                        _isSelectingCheckIn = true;
                      }),
                    ),
                    const SizedBox(height: 16),
                    const Text('Check-out Date', style: TextStyle(fontSize: 12, color: AppTheme.textGray)),
                    const SizedBox(height: 8),
                    _DateCard(
                      date: _checkOutDate,
                      color: AppTheme.goldAccent,
                      onTap: () => setState(() {
                        _showCalendar = !_showCalendar;
                        _isSelectingCheckIn = false;
                      }),
                    ),
                    if (_showCalendar) ...[
                      const SizedBox(height: 16),
                      _CalendarWidget(
                        selectedCheckIn: _checkInDate,
                        selectedCheckOut: _checkOutDate,
                        onDateSelected: (date) {
                          setState(() {
                            if (_isSelectingCheckIn) {
                              _checkInDate = date;
                              if (_checkOutDate.isBefore(_checkInDate)) {
                                _checkOutDate = _checkInDate.add(const Duration(days: 1));
                              }
                            } else {
                              if (date.isAfter(_checkInDate)) {
                                _checkOutDate = date;
                              }
                            }
                            _showCalendar = false;
                          });
                        },
                      ),
                    ],
                    const SizedBox(height: 16),
                    const Text('Number of Guests', style: TextStyle(fontSize: 12, color: AppTheme.textGray)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.borderColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.goldAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.people, color: AppTheme.goldAccent, size: 24),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$_guests Guests', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                const Text('Adults', style: TextStyle(fontSize: 14, color: AppTheme.textGray)),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (_guests > 1) setState(() => _guests--);
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                            color: Colors.white,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppTheme.darkBackground,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('$_guests', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
                          IconButton(
                            onPressed: () => setState(() => _guests++),
                            icon: const Icon(Icons.add_circle_outline),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.borderColor),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Duration', style: TextStyle(fontSize: 14, color: AppTheme.textGray)),
                              Text('$nights nights', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Guests', style: TextStyle(fontSize: 14, color: AppTheme.textGray)),
                              Text('$_guests guests', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppTheme.cardBackground,
                border: Border(top: BorderSide(color: AppTheme.borderColor)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerAvailableRoomsScreen())),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.goldAccent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, size: 20),
                      SizedBox(width: 8),
                      Text('Search Available Rooms', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Highlight Search/Booking tab
        onTap: _onNavigationTap, // Gunakan method navigasi
        backgroundColor: AppTheme.cardBackground,
        selectedItemColor: AppTheme.goldAccent,
        unselectedItemColor: AppTheme.textGray,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class _DateCard extends StatelessWidget {
  final DateTime date;
  final Color color;
  final VoidCallback onTap;

  const _DateCard({required this.date, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final dateStr = '${_getWeekday(date.weekday)}, ${_getMonth(date.month)} ${date.day}, ${date.year}';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.calendar_today, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 16),
            Text(dateStr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  String _getWeekday(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  String _getMonth(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}

class _CalendarWidget extends StatelessWidget {
  final DateTime selectedCheckIn;
  final DateTime selectedCheckOut;
  final Function(DateTime) onDateSelected;

  const _CalendarWidget({
    required this.selectedCheckIn,
    required this.selectedCheckOut,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left, color: Colors.white)),
              const Text('December 2025', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_right, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, childAspectRatio: 1),
            itemCount: 35,
            itemBuilder: (context, index) {
              if (index < 7) {
                const days = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
                return Center(child: Text(days[index], style: const TextStyle(fontSize: 12, color: AppTheme.textGray)));
              }

              final day = index - 6;
              final date = DateTime(2025, 12, day);
              final isCheckIn = date.day == selectedCheckIn.day && date.month == selectedCheckIn.month;
              final isCheckOut = date.day == selectedCheckOut.day && date.month == selectedCheckOut.month;
              final isInRange = date.isAfter(selectedCheckIn) && date.isBefore(selectedCheckOut);

              return GestureDetector(
                onTap: () => onDateSelected(date),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isCheckIn
                        ? AppTheme.emeraldGreen
                        : isCheckOut
                            ? AppTheme.goldAccent
                            : isInRange
                                ? AppTheme.goldAccent.withOpacity(0.2)
                                : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      day > 31 ? '' : day.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: (isCheckIn || isCheckOut)
                            ? Colors.white
                            : day == 13
                                ? AppTheme.goldAccent
                                : Colors.white,
                        fontWeight: (isCheckIn || isCheckOut || day == 17) ? FontWeight.bold : FontWeight.normal,
                      ),
                    ), 
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}