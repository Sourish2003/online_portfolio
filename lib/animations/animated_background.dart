import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  final List<Color> gradientColors;
  final double sensitivity;

  const AnimatedBackground({
    super.key,
    required this.child,
    this.gradientColors = const [
      Color(0xFF1A1A2E),
      Color(0xFF16213E),
      Color(0xFF0F3460),
      Color(0xFF541690),
    ],
    this.sensitivity = 0.015,
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  Offset _mousePosition = Offset.zero;
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return RepaintBoundary(
      child: MouseRegion(
        onHover: isDesktop
            ? (event) {
                setState(() {
                  _mousePosition = event.position;
                });
              }
            : null,
        child: Stack(
          children: [
            // Animated gradient background
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                // Calculate gradient position based on mouse movement
                // Gradient center adjusts based on mouse position
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(
                        -1.0 + 2 * (_mousePosition.dx / size.width),
                        -1.0 + 2 * (_mousePosition.dy / size.height),
                      ),
                      radius: 1.5 * _pulseAnimation.value,
                      colors: widget.gradientColors,
                      stops: const [0.1, 0.4, 0.7, 1.0],
                    ),
                  ),
                );
              },
            ),
            // Animated particles
            Positioned.fill(
              child: AnimatedParticles(
                mousePosition: _mousePosition,
                particleCount: isDesktop ? 24 : 12,
                animationDuration: isDesktop ? const Duration(seconds: 12) : const Duration(seconds: 18),
              ),
            ),
            // Content
            widget.child,
          ],
        ),
      ),
    );
  }
}

class AnimatedParticles extends StatefulWidget {
  final Offset mousePosition;
  final int particleCount;
  final Duration animationDuration;

  const AnimatedParticles({
    super.key,
    required this.mousePosition,
    this.particleCount = 24,
    this.animationDuration = const Duration(seconds: 12),
  });

  @override
  State<AnimatedParticles> createState() => _AnimatedParticlesState();
}

class _AnimatedParticlesState extends State<AnimatedParticles>
    with TickerProviderStateMixin {
  final List<Particle> _particles = [];
  late final AnimationController _animationController;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat();

    // Initialize particles
    for (int i = 0; i < widget.particleCount; i++) {
      _particles.add(Particle(
        position: Offset(
          _random.nextDouble() * 1000,
          _random.nextDouble() * 1000,
        ),
        size: 2 + _random.nextDouble() * 6,
        opacity: 0.2 + _random.nextDouble() * 0.6,
        speed: 0.18 + _random.nextDouble() * 0.5,
        angle: _random.nextDouble() * math.pi * 2,
      ));
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          for (var particle in _particles) {
            // Move particle based on its speed and angle
            particle.position = Offset(
              (particle.position.dx + math.cos(particle.angle) * particle.speed) %
                  size.width,
              (particle.position.dy + math.sin(particle.angle) * particle.speed) %
                  size.height,
            );

            // Slightly adjust angle based on mouse position
            final double distanceToMouse =
                (particle.position - widget.mousePosition).distance;
            if (distanceToMouse < 200) {
              particle.angle += (0.01 * (200 - distanceToMouse) / 200);
            }
          }
          return CustomPaint(
            painter: ParticlePainter(particles: _particles),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class Particle {
  Offset position;
  double size;
  double opacity;
  double speed;
  double angle;

  Particle({
    required this.position,
    required this.size,
    required this.opacity,
    required this.speed,
    required this.angle,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paint = Paint()
        ..color = Colors.white.withValues(alpha: particle.opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(particle.position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}
