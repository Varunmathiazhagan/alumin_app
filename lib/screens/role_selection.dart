import 'package:flutter/material.dart';
import 'dart:math' as math;

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  _RoleSelectionPageState createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Gradient Background
          AnimatedContainer(
            duration: const Duration(seconds: 10),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.5, -0.5),
                radius: 1.5,
                colors: [
                  Colors.blue.shade900,
                  Colors.blue.shade700,
                  Colors.purple.shade600.withOpacity(0.8),
                  Colors.blue.shade400,
                ],
                stops: const [0.0, 0.4, 0.7, 1.0],
              ),
            ),
            onEnd: () {
              setState(() {});
            },
          ),
          // Subtle Particle Background
          CustomPaint(
            painter: ParticlePainter(),
            child: Container(),
          ),
          // Main Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Logo
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade300.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.school,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Title and Tagline
                  Text(
                    'Alumni Connect',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Unite, Inspire, Succeed',
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Choose your role to begin',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Role Selection Card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          _buildRoleButton(
                            context,
                            'Alumni',
                            'Join the alumni network',
                            Colors.blue.shade800,
                            Icons.group,
                            '/login',
                            {'role': 'alumni'},
                            showSignup: true,
                          ),
                          const SizedBox(height: 20),
                          _buildRoleButton(
                            context,
                            'Current Student',
                            'Connect with peers',
                            Colors.green.shade800,
                            Icons.school,
                            '/login',
                            {'role': 'student'},
                            showSignup: true,
                          ),
                          const SizedBox(height: 20),
                          _buildRoleButton(
                            context,
                            'Admin',
                            'Manage the platform',
                            Colors.red.shade800,
                            Icons.admin_panel_settings,
                            '/login',
                            {'role': 'admin'},
                            showSignup: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleButton(
    BuildContext context,
    String title,
    String subtitle,
    Color color,
    IconData icon,
    String route,
    Map<String, String> arguments, {
    bool showSignup = true,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTapDown: (_) {
            setState(() {});
          },
          onTapUp: (_) {
            setState(() {});
            Navigator.pushNamed(context, route, arguments: arguments);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.identity()
              ..rotateZ(0.0), // Subtle tilt effect can be added here
            transformAlignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color,
                  color.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.7),
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        if (showSignup)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: TextButton(
              onPressed: () => Navigator.pushNamed(context, '/signup', arguments: arguments),
              child: Text(
                'Sign Up as $title',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// Custom Painter for Subtle Particle Background
class ParticlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final random = math.Random();
    for (int i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}