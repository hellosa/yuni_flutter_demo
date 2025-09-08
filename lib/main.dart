import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meetist',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE91E63),
              Color(0xFF9C27B0),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background image cards
            _buildFloatingImages(),
            
            // Main content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(flex: 3),
                    
                    // Welcome text
                    const Text(
                      'Welcome to\nMeetist',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.0,
                      ),
                    ),
                    
                    const SizedBox(height: 50),
                    
                    // Subtitle
                    const Text(
                      'Where you will get in touch with other artist like you',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    
                    const SizedBox(height: 100),
                    
                    // Google Sign In Button
                    _buildGoogleSignInButton(),
                    
                    const SizedBox(height: 22),
                    
                    // Apple Sign In Button
                    _buildAppleSignInButton(),
                    
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingImages() {
    return Stack(
      children: [
        // Top left area
        Positioned(
          left: -21,
          top: -47,
          child: _buildImageCard(
            'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=108&h=157&fit=crop',
          ),
        ),
        Positioned(
          left: -21,
          top: 121,
          child: _buildImageCard(
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=108&h=157&fit=crop',
          ),
        ),
        
        // Middle column
        Positioned(
          left: 101,
          top: -90,
          child: _buildImageCard(
            'https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?w=108&h=157&fit=crop',
          ),
        ),
        Positioned(
          left: 101,
          top: 78,
          child: _buildImageCard(
            'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=108&h=157&fit=crop',
          ),
        ),
        
        // Right column
        Positioned(
          left: 223,
          top: 10,
          child: _buildImageCard(
            'https://images.unsplash.com/photo-1494790108755-2616c830512f?w=108&h=157&fit=crop',
          ),
        ),
        Positioned(
          left: 223,
          top: 178,
          child: _buildImageCard(
            'https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=108&h=157&fit=crop',
          ),
        ),
        
        // Far right column
        Positioned(
          left: 345,
          top: -63,
          child: _buildImageCard(
            'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=108&h=157&fit=crop',
          ),
        ),
        Positioned(
          left: 345,
          top: 106,
          child: _buildImageCard(
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=108&h=157&fit=crop',
          ),
        ),
      ],
    );
  }

  Widget _buildImageCard(String imageUrl) {
    return Container(
      width: 108,
      height: 157,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.6),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton() {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.082),
            blurRadius: 3,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.17),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://developers.google.com/identity/images/g-logo.png',
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 15),
          const Text(
            'Sign In with Google',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0x8A000000),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppleSignInButton() {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.082),
            blurRadius: 3,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.17),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.apple,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(width: 15),
          Text(
            'Sign In with Apple',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
