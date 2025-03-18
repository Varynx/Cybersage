import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;

  Future<void> _storeLoginData() async {
    setState(() {
      _isLoading = true;
    });
  
  try {
      final String username = usernameController.text.trim();
      final String password = passwordController.text.trim();

      //Sets up formatting for the firebase in the 
      await _firestore.collection('Login_Info').add({
        'username': username, //Stores Username
        'password': password, //Stores Password
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        Navigator.pushNamed(context, '/quiz');
      }
    } catch (e) {
      print('Error storing data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }//store loginData function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CyberSage Login', style: TextStyle(fontSize: 22)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView( // Add scrolling for smaller screens
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // CYBERSAGE LOGO
              Container(
                height: 120,
                margin: const EdgeInsets.only(bottom: 40, top: 20),
                child: Center(
                  child: Text(
                    "CyberSage",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
          
                  // child: Image.asset('assets/cyber_sage_logo.png'),
                ),
              ),
              
              const Text(
                'Welcome to CyberSage',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 30),
              
              const Text(
                'Username',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField( 
                controller: usernameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your username',
                  prefixIcon: Icon(Icons.person),
                ),
                style: const TextStyle(fontSize: 18),
              ),
              
              const SizedBox(height: 24),
              
              const Text(
                'Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock),
                ),
                style: const TextStyle(fontSize: 18),
              ),
              
              const SizedBox(height: 40),
              
              ElevatedButton(
                onPressed: _isLoading ? null : _storeLoginData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Login', style: TextStyle(fontSize: 20)),
              ),
              
              const SizedBox(height: 16),
              
              // Help text for elderly users
              const Text(
                'Need help? Contact support or ask for assistance',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}