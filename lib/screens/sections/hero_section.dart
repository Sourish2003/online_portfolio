import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:online_portfolio/animations/animated_reveal.dart';
import 'package:responsive_framework/responsive_framework.dart';

// Custom Parallax implementation
class SimpleParallax extends StatefulWidget {
  final Widget child;
  final double depth;

  const SimpleParallax({super.key, required this.child, this.depth = 0.05});

  @override
  State<SimpleParallax> createState() => _SimpleParallaxState();
}

class _SimpleParallaxState extends State<SimpleParallax> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        final size = MediaQuery.of(context).size;
        final dx = (event.position.dx - size.width / 2) / (size.width / 2);
        final dy = (event.position.dy - size.height / 2) / (size.height / 2);
        setState(() {
          _offset = Offset(dx * widget.depth, dy * widget.depth);
        });
      },
      onExit: (_) {
        setState(() {
          _offset = Offset.zero;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutQuad,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_offset.dy)
          ..rotateY(-_offset.dx)
          ..translate(_offset.dx * 15, _offset.dy * 15),
        child: widget.child,
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    final isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);

    return SimpleParallax(
      depth: 0.03,
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: isDesktop
            ? _buildDesktopLayout(context, theme, isMobile)
            : _buildMobileLayout(context, theme, isMobile),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, ThemeData theme, bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Column with Image for desktop
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: _buildProfileImage(theme, 400.0),
          ),
        ),

        // Right Column with Text
        Expanded(
          flex: 1,
          child: _buildTextContent(context, theme, isMobile),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, ThemeData theme, bool isMobile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile Image at the top for mobile
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: _buildProfileImage(theme, 280.0),
        ),
        _buildTextContent(context, theme, isMobile, isColumn: true),
      ],
    );
  }

  Widget _buildProfileImage(ThemeData theme, double size) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: 1.0,
      child: Transform.translate(
        offset: const Offset(0, 0),
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 40.0,
                spreadRadius: 10.0,
              ),
            ],
            image: const DecorationImage(
              image: AssetImage('assets/images/profile_placeholder.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextContent(BuildContext context, ThemeData theme, bool isMobile, {bool isColumn = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: isColumn ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        AnimatedRevealItems(
          crossAxisAlignment: isColumn ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          staggerDelay: const Duration(milliseconds: 250),
          children: [
            Text(
              'Hello, I\'m',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.textTheme.headlineMedium?.color,
              ),
              textAlign: isColumn ? TextAlign.center : TextAlign.start,
            ),
            Text(
              'Sourish Merugumilli',
              style: theme.textTheme.displayLarge?.copyWith(
                color: theme.textTheme.displayLarge?.color,
                fontSize: isMobile ? 36 : null,
              ),
              textAlign: isColumn ? TextAlign.center : TextAlign.start,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: isColumn ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                Text(
                  'I\'m a ',
                  style: theme.textTheme.headlineMedium,
                ),
                DefaultTextStyle(
                  style: theme.textTheme.headlineMedium!.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Software Developer',
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        'Web Designer',
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        'Mobile Developer',
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        'UI/UX Designer',
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: isMobile ? double.infinity : 400,
              child: Text(
                'Passionate about creating beautiful, responsive, and user-friendly applications. Experienced in various programming languages and frameworks.',
                style: theme.textTheme.bodyLarge,
                textAlign: isColumn ? TextAlign.center : TextAlign.start,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: isColumn ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                HeroButton(
                  title: 'Contact Me',
                  isPrimary: true,
                  onTap: () {},
                ),
                const SizedBox(width: 20),
                HeroButton(
                  title: 'View Resume',
                  isPrimary: false,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class HeroButton extends StatefulWidget {
  final String title;
  final bool isPrimary;
  final VoidCallback onTap;

  const HeroButton({
    super.key,
    required this.title,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<HeroButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? (_isHovering
                ? theme.colorScheme.primary
                : theme.colorScheme.primary.withValues(alpha: 0.8))
                : (_isHovering
                ? theme.colorScheme.surface.withValues(alpha: 0.2)
                : Colors.transparent),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: widget.isPrimary
                  ? Colors.transparent
                  : theme.colorScheme.primary.withValues(alpha: 0.5),
              width: 2,
            ),
            boxShadow: _isHovering && widget.isPrimary
                ? [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ]
                : [],
          ),
          child: Text(
            widget.title,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: widget.isPrimary
                  ? theme.colorScheme.onPrimary
                  : _isHovering
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}