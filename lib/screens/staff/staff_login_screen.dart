import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/hotel_logo.dart';
import 'staff_main_screen.dart'; // ✅ UBAH: Import StaffMainScreen, bukan StaffDashboardScreen

class StaffLoginScreen extends StatefulWidget {
  const StaffLoginScreen({super.key});

  @override
  State<StaffLoginScreen> createState() => _StaffLoginScreenState();
}

class _StaffLoginScreenState extends State<StaffLoginScreen> {
  bool _obscurePassword = true;
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();

  String? _validateGmailEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    
    final gmailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
    
    if (!gmailRegex.hasMatch(value)) {
      return 'Email harus berformat @gmail.com';
    }
    
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    return null;
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextEditingController? controller, 
    String? Function(String?)? validator, 
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: TextFormField( 
        controller: controller, 
        validator: validator,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        keyboardType: hint.contains('email') 
            ? TextInputType.emailAddress 
            : TextInputType.text, 
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppTheme.textDarkGray),
          prefixIcon: Icon(icon, color: AppTheme.textGray),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          errorStyle: const TextStyle(color: Colors.redAccent),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // ✅ UBAH: Navigasi ke StaffMainScreen dengan initialIndex: 0 (Dashboard)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const StaffMainScreen(initialIndex: 0),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan isi data yang benar'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form( 
            key: _formKey, 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: AppTheme.cardBackground,
                  ),
                ),
                const SizedBox(height: 40),
                const Center(
                  child: HotelLogo(size: HotelLogoSize.medium, showTagline: false),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.emeraldGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.emeraldGreen),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shield_outlined, color: AppTheme.emeraldGreen, size: 16),
                        SizedBox(width: 6),
                        Text(
                          'Staff Portal',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.emeraldGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Staff Login',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Access your management dashboard',
                  style: TextStyle(fontSize: 14, color: AppTheme.textGray),
                ),
                const SizedBox(height: 40),
                _buildTextField(
                  hint: 'Staff email',
                  icon: Icons.email_outlined,
                  controller: _emailController,
                  validator: _validateGmailEmail,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  hint: 'Password',
                  icon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  controller: _passwordController, 
                  validator: _validatePassword, 
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: AppTheme.textGray,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: AppTheme.emeraldLight, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _handleLogin, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.emeraldGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Sign In to Dashboard',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: 'Need help accessing your account? ',
                      style: TextStyle(color: AppTheme.textGray, fontSize: 12),
                      children: [
                        TextSpan(
                          text: 'Contact IT Support',
                          style: TextStyle(
                            color: AppTheme.emeraldLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}