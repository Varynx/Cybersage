import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Form key to handle form validation
  final _formKey = GlobalKey<FormState>();

  // Controllers to read user input from email and password fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // State flags to control visibility of password and loading state
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  // Error messages for email, password, and general errors
  String? _emailError;
  String? _passwordError;
  String? _generalError;

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Login method that attempts to sign in the user
  Future<void> _login() async {
    // Validate the form before proceeding
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _emailError = null;
      _passwordError = null;
    });

    // Call AuthService to attempt sign in and get potential errors
    final error = await AuthService().signin(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      context: context,
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
        if (error != null) {
          // Map error messages to specific fields
          if (error.toLowerCase().contains('email')) {
            _emailError = error;
          } else if (error.toLowerCase().contains('password')) {
            _passwordError = error;
          } else {
            _generalError = error; // default to general error
          }
        }
      });
    }
  }

  // Builds the email field with validation and error handling
  Widget _buildEmailField(ColorScheme cs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 8),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Enter your email',
            prefixIcon: const Icon(Icons.email_outlined),
            filled: true,
            fillColor: cs.surface,
            errorText: _emailError, // Displays error message if any
          ),
          validator: (v) {
            if (v == null || v.isEmpty) return 'Please enter your email';
            if (!v.contains('@')) return 'Enter a valid email';
            return null;
          },
        ),
      ],
    );
  }

  // Builds the password field with visibility toggle and validation
  Widget _buildPasswordField(ColorScheme cs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            prefixIcon: const Icon(Icons.lock_outline),
            filled: true,
            fillColor: cs.surface,
            errorText: _passwordError, // Displays error message if any
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          enableSuggestions: false,
          autocorrect: false,
          validator: (v) {
            if (v == null || v.isEmpty) return 'Please enter your password';
            if (v.length < 6) return 'Password must be at least 6 characters';
            return null;
          },
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  // Builds the login button, showing a loading spinner when in loading state
  Widget _buildLoginButton(ColorScheme cs) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _login, // Disable when loading
      style: ElevatedButton.styleFrom(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child:
          _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text('Login'),
    );
  }

  // Builds the "No account? Sign Up" prompt
  Widget _buildSignupText(ColorScheme cs) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("No account? "),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, '/signup'),
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: cs.secondary,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CyberSage Login', style: TextStyle(fontSize: 22)),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // CYBERSAGE LOGO
              Container(
                height: 240,
                margin: const EdgeInsets.only(bottom: 80, top: 40),
                child: Center(
                  child: Image.asset(
                    'cybersage_no_person.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Email & password fields
              _buildEmailField(cs),
              const SizedBox(height: 20),
              _buildPasswordField(cs),

              const SizedBox(height: 30),

              // Display general error if any
              if (_generalError != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    _generalError!,
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Login button
              _buildLoginButton(cs),

              const SizedBox(height: 20),

              // Signup prompt
              _buildSignupText(cs),
            ],
          ),
        ),
      ),
    );
  }
}
