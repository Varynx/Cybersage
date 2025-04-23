import 'package:flutter/material.dart';
import '../auth_service.dart';

/// Signup page for new user registration
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // Form key to manage validation
  final _formKey = GlobalKey<FormState>();

  // Text field controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // State variables for loading & password visibility
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  String? _emailError;
  String? _passwordError;
  String? _generalError;
  @override
  void dispose() {
    // Clean up controllers when widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() {
    _emailError = null;
    _passwordError = null;
    _generalError = null;
  });

  final error = await AuthService().signup(
    email: _emailController.text.trim(),
    password: _passwordController.text.trim(),
    context: context,
  );

  if (mounted) {
    setState(() {
      if (error != null) {
        if (error.contains('email')) {
          _emailError = error;
        } else if (error.contains('password')) {
          _passwordError = error;
        } else {
          _generalError = error;
        }
      }
    });
  }
}


  /// Builds the external label and email input field
  Widget _buildEmailField(ColorScheme cs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // External label
        Text(
          'Email Address',
          style: TextStyle(fontSize: 18,color: Colors.black),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'you@example.com',
            filled: true,
            fillColor: cs.surface,
            errorText: _emailError,
          ),
          validator: (v) {
            if (v == null || v.isEmpty) return 'Please enter your email';
            final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
            if (!regex.hasMatch(v)) return 'Enter a valid email';
            return null;
          },
        ),
      ],
    );
  }

  /// Builds the external label and password input field
  Widget _buildPasswordField(ColorScheme cs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // External label
        Text(
          'Password',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            filled: true,
            fillColor: cs.surface,
            errorText: _passwordError,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() => _isPasswordVisible = !_isPasswordVisible);
              },
            ),
          ),
          enableSuggestions: false,
          autocorrect: false,
          validator: (v) {
            if (v == null || v.isEmpty) return 'Please enter your password';
            if (v.length < 6) return 'Must be at least 6 characters';
            return null;
          },
        ),
        const SizedBox(height: 4),
        // Informational minimum length message
        Text(
          'Password must be at least 6 characters.',
          style: TextStyle(color: Color(0xff6A6A6A), fontSize: 14),
        ),
      ],
    );
  }

  /// Builds the sign-up button
  Widget _buildSignupButton(ColorScheme cs) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _signup,
      style: ElevatedButton.styleFrom(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child:
          _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text('Sign Up'),
    );
  }

  /// Builds the "Already have an account? Log In" prompt
  Widget _buildLoginText(ColorScheme cs) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account? "),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
            child: Text(
              'Log In',
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
        title: const Text('CyberSage Sign Up', style: TextStyle(fontSize: 22)),
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
              const SizedBox(height: 24),

              // Main Header
              Text(
                'Register Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
              ),

              const SizedBox(height: 40),

              // Email field with external label
              _buildEmailField(cs),

              const SizedBox(height: 20),

              // Password field with external label
              _buildPasswordField(cs),

              const SizedBox(height: 30),
              //if there is a general error, then the general error message is displayed in a separate textbox
              if (_generalError != null)
                Padding
                (
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text
                  (
                    _generalError!,
                    style: TextStyle
                    (
                      color: Colors.red[700],
                      fontSize:  14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              // Sign Up button
              _buildSignupButton(cs),

              const SizedBox(height: 20),

              // Login prompt right under fields
              _buildLoginText(cs),
            ],
          ),
        ),
      ),
    );
  }
}
