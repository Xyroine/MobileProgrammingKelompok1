import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/hotel_logo.dart';
import 'staff_dashboard_screen.dart';

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

  // ✅ TAMBAHAN BARU: Variable untuk cek password strength
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasDigit = false;
  bool _hasSpecialChar = false;

  @override
  void initState() {
    super.initState();
    // ✅ Listen perubahan password
    _passwordController.addListener(_checkPasswordStrength);
  }

  // ✅ TAMBAHAN BARU: Fungsi cek password strength real-time
  void _checkPasswordStrength() {
    final password = _passwordController.text;
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
      _hasLowercase = RegExp(r'[a-z]').hasMatch(password);
      _hasDigit = RegExp(r'[0-9]').hasMatch(password);
      _hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    });
  }

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

  String? _validateStrongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    
    if (value.length < 8) {
      return 'Password minimal 8 karakter';
    }
    
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password harus ada huruf besar (A-Z)';
    }
    
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password harus ada huruf kecil (a-z)';
    }
    
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password harus ada angka (0-9)';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password harus ada simbol seperti !@#\$%^&*';
    }
    
    return null;
  }

  // ✅ TAMBAHAN BARU: Widget untuk requirement item
  Widget _buildRequirement(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: isMet ? AppTheme.emeraldGreen : AppTheme.textDarkGray,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: isMet ? AppTheme.emeraldGreen : AppTheme.textGray,
                fontWeight: isMet ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const StaffDashboardScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan perbaiki data yang salah'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _passwordController.removeListener(_checkPasswordStrength); // ✅ TAMBAHAN
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
                  validator: _validateStrongPassword,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: AppTheme.textGray,
                    ),
                  ),
                ),
                // ✅ TAMBAHAN BARU: Password Requirements Indicator
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackground.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.borderColor.withOpacity(0.5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Password harus mengandung:',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textGray,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildRequirement('Minimal 8 karakter', _hasMinLength),
                      _buildRequirement('Huruf besar (A-Z)', _hasUppercase),
                      _buildRequirement('Huruf kecil (a-z)', _hasLowercase),
                      _buildRequirement('Angka (0-9)', _hasDigit),
                      _buildRequirement('Simbol (!@#\$%^&*)', _hasSpecialChar),
                    ],
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