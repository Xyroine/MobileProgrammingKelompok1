import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/booking_model.dart';

class CustomerPaymentScreen extends StatefulWidget {
  final String roomName;
  final int pricePerNight;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int guests;
  final int nights;
  final int totalPrice;
  final String imageUrl;

  const CustomerPaymentScreen({
    super.key,
    required this.roomName,
    required this.pricePerNight,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guests,
    required this.nights,
    required this.totalPrice,
    required this.imageUrl,
  });

  @override
  State<CustomerPaymentScreen> createState() => _CustomerPaymentScreenState();
}

class _CustomerPaymentScreenState extends State<CustomerPaymentScreen> {
  String _selectedPayment = 'QRIS';
  bool _isProcessing = false;

  void _processPayment() {
    setState(() => _isProcessing = true);

    // Simulasi pembayaran (2 detik)
    Future.delayed(const Duration(seconds: 2), () {
      // Simpan booking ke history
      final booking = Booking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        roomName: widget.roomName,
        checkInDate: widget.checkInDate,
        checkOutDate: widget.checkOutDate,
        guests: widget.guests,
        nights: widget.nights,
        totalPrice: widget.totalPrice,
        imageUrl: widget.imageUrl,
        bookingDate: DateTime.now(),
        status: 'Confirmed',
      );

      BookingService.addBooking(booking);

      // Kembali ke home (pop 3x: payment -> detail -> available rooms -> home)
      Navigator.of(context).popUntil((route) => route.isFirst);

      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment successful! Booking confirmed.'),
          backgroundColor: AppTheme.emeraldGreen,
          duration: Duration(seconds: 3),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateStr =
        '${_getMonthShort(widget.checkInDate.month)} ${widget.checkInDate.day} - ${_getMonthShort(widget.checkOutDate.month)} ${widget.checkOutDate.day}';

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text('Payment',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Serif',
                color: Colors.white)),
      ),
      body: _isProcessing
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppTheme.goldAccent),
                  SizedBox(height: 20),
                  Text('Processing payment...',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. BOOKING SUMMARY
                  const Text('Booking Summary',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                          color: Colors.white)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.borderColor),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.roomName,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Serif',
                                      color: Colors.white)),
                              const SizedBox(height: 4),
                              Text(dateStr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.textGray)),
                              Text('${widget.guests} guests',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.textGray)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // 2. PRICE BREAKDOWN
                  const Text('Price Details',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                          color: Colors.white)),
                  const SizedBox(height: 16),
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
                            Text(
                                '\$${widget.pricePerNight} × ${widget.nights} nights',
                                style: const TextStyle(
                                    fontSize: 14, color: AppTheme.textGray)),
                            Text('\$${widget.totalPrice}',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Service fee',
                                style: TextStyle(
                                    fontSize: 14, color: AppTheme.textGray)),
                            Text('\$0',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Taxes',
                                style: TextStyle(
                                    fontSize: 14, color: AppTheme.textGray)),
                            Text('\$0',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                          ],
                        ),
                        const Divider(
                            color: AppTheme.borderColor, height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Text('\$${widget.totalPrice}',
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.goldAccent)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // 3. PAYMENT METHOD
                  const Text('Payment Method',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                          color: Colors.white)),
                  const SizedBox(height: 16),

                  _PaymentMethodCard(
                    icon: Icons.qr_code_2,
                    label: 'QRIS',
                    isSelected: _selectedPayment == 'QRIS',
                    onTap: () => setState(() => _selectedPayment = 'QRIS'),
                  ),
                  const SizedBox(height: 12),
                  _PaymentMethodCard(
                    icon: Icons.credit_card,
                    label: 'Credit Card',
                    isSelected: _selectedPayment == 'Credit Card',
                    onTap: () =>
                        setState(() => _selectedPayment = 'Credit Card'),
                  ),
                  const SizedBox(height: 12),
                  _PaymentMethodCard(
                    icon: Icons.account_balance_wallet,
                    label: 'E-Wallet',
                    isSelected: _selectedPayment == 'E-Wallet',
                    onTap: () => setState(() => _selectedPayment = 'E-Wallet'),
                  ),

                  const SizedBox(height: 32),

                  // 4. QRIS CODE (jika dipilih)
                  if (_selectedPayment == 'QRIS') ...[
                    const Text('Scan QR Code',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Serif',
                            color: Colors.white)),
                    const SizedBox(height: 16),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Image.network(
                              'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=LUXESTAY-${widget.totalPrice}',
                              width: 200,
                              height: 200,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Total: \$${widget.totalPrice}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // 5. CONFIRM BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _processPayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.goldAccent,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        _selectedPayment == 'QRIS'
                            ? 'I\'ve Paid'
                            : 'Confirm Payment',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  String _getMonthShort(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}

// ==========================================
// PAYMENT METHOD CARD
// ==========================================

class _PaymentMethodCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodCard({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.goldAccent : AppTheme.borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.goldAccent.withOpacity(0.2)
                    : Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon,
                  color: isSelected ? AppTheme.goldAccent : Colors.white,
                  size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(label,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: Colors.white)),
            ),
            if (isSelected)
              const Icon(Icons.check_circle,
                  color: AppTheme.goldAccent, size: 24),
          ],
        ),
      ),
    );
  }
}