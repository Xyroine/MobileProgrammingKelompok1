import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import koneksi
import 'dart:convert'; // Import JSON decoder
import '../../theme/app_theme.dart';
import '../../widgets/hotel_logo.dart';
// ✅ UBAH: Import file yang benar
import 'customer_home_screen.dart'; 

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({super.key});

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  bool _obscurePassword = true;
  bool _isLoading = false; // Status loading
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();

  // Validasi Email Customer
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    
    if (!emailRegex.hasMatch(value)) {
      return 'Masukkan format email yang valid';
    }
    
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    return null;
  }

  // --- FUNGSI LOGIN CUSTOMER ---
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Tembak ke API Customer
      // Gunakan 10.0.2.2 jika Emulator, atau IP Laptop jika HP Fisik
      final url = Uri.parse('http://10.0.2.2/hotel_api/login_customer.php');
      
      final response = await http.post(
        url,
        body: {
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );

      // 2. Cek Respon
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          // --- LOGIN SUKSES ---
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login Berhasil! Selamat datang.'),
                backgroundColor: Colors.green,
              ),
            );

            // ✅ UBAH: Navigasi ke CustomerHomeScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const CustomerHomeScreen(), // Pastikan nama class-nya ini
              ),
            );
          }
        } else {
          // --- LOGIN GAGAL ---
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(data['message'] ?? 'Login Gagal'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } else {
        // --- ERROR SERVER ---
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error Server: ${response.statusCode}'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      // --- ERROR KONEKSI ---
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal koneksi. Cek internet/server.\nError: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
        enabled: !_isLoading, 
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
                  onPressed: _isLoading ? null : () => Navigator.pop(context),
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
                      color: AppTheme.cardBackground, 
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.borderColor),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person_outline, color: Colors.white, size: 16),
                        SizedBox(width: 6),
                        Text(
                          'Guest Login',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sign in to book rooms and manage stays',
                  style: TextStyle(fontSize: 14, color: AppTheme.textGray),
                ),
                const SizedBox(height: 40),
                
                _buildTextField(
                  hint: 'Email address',
                  icon: Icons.email_outlined,
                  controller: _emailController,
                  validator: _validateEmail,
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
                    onPressed: _isLoading ? null : _handleLogin, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.emeraldGreen,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppTheme.emeraldGreen.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading 
                        ? const SizedBox(
                            height: 24, 
                            width: 24, 
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text(
                            'Sign In',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                
                const SizedBox(height: 60),
                
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: AppTheme.textGray, fontSize: 12),
                      children: [
                        TextSpan(
                          text: 'Create Account',
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