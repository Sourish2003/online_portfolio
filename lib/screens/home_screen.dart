import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_portfolio/animations/animated_background.dart';
import 'package:online_portfolio/animations/cursor_animation.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/section_divider.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';

// Utility function to launch URLs
void launchURL(String url) async {
  try {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri);
  } catch (e) {
    debugPrint('Could not launch $url: $e');
  }
}

class HomeScreen extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  const HomeScreen({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;
  int _currentSection = 0;

  final List<String> _sections = ['Home', 'About', 'Projects', 'Contact'];
  final List<GlobalKey> _sectionKeys = List.generate(4, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    // Ensure we update the current section after the first layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateCurrentSectionFromScroll();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _showScrollToTop = _scrollController.offset > 300;
    });

    // Debounce the section update to make it more efficient
    _updateCurrentSectionFromScroll();
  }

  void _updateCurrentSectionFromScroll() {
    // Get the scrollable area height and current scroll position
    final scrollBox = context.findRenderObject() as RenderBox?;
    final scrollHeight = scrollBox?.size.height ?? 0;
    final scrollOffset = _scrollController.offset;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;

    // If at the very bottom, set to last section
    if ((scrollOffset + 10) >= maxScrollExtent) {
      if (_currentSection != _sectionKeys.length - 1) {
        setState(() {
          _currentSection = _sectionKeys.length - 1;
        });
      }
      return;
    }

    // Otherwise, check which section is closest to the top
    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx != null) {
        final RenderBox box = ctx.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);
        // If the section is within 100px from the top, or if it's the last section and mostly visible
        if (position.dy <= 100 || (i == _sectionKeys.length - 1 && position.dy < scrollHeight - 200)) {
          if (_currentSection != i) {
            setState(() {
              _currentSection = i;
            });
          }
          break;
        }
      }
    }
  }

  void _scrollToSection(int index) {
    // Fix for navigation - ensure ScrollController is used properly
    if (_sectionKeys[index].currentContext != null) {
      final RenderBox box =
      _sectionKeys[index].currentContext!.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero);

      // Calculate the target scroll offset
      final double targetOffset = _scrollController.offset + position.dy - 80;

      // Use the ScrollController directly to perform the scroll
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );

      // Update the current section index
      setState(() {
        _currentSection = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    final isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);

    return CursorAnimation(
      defaultColor: theme.colorScheme.primary.withValues(alpha: 0.3),
      hoverColor: theme.colorScheme.secondary.withValues(alpha: 0.5),
      child: AnimatedBackground(
        gradientColors: widget.isDarkMode
            ? const [
          Color(0xFF1A1A2E),
          Color(0xFF16213E),
          Color(0xFF0F3460),
          Color(0xFF541690),
        ]
            : const [
          Color(0xFFF8F9FA),
          Color(0xFFE9ECEF),
          Color(0xFFDEE2E6),
          Color(0xFFCED4DA),
        ],
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: isDesktop
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _sections.length,
                    (index) => NavBarItem(
                  title: _sections[index],
                  isActive: _currentSection == index,
                  onTap: () => _scrollToSection(index),
                ),
              ),
            )
                : null,
            actions: [
              IconButton(
                icon: Icon(
                  widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: theme.colorScheme.primary,
                ),
                onPressed: () => widget.toggleTheme(),
              ),
              const SizedBox(width: 16),
            ],
          ),
          drawer: isMobile
              ? Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                  ),
                  child: Text(
                    'Menu',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
                ...List.generate(
                  _sections.length,
                      (index) => ListTile(
                    title: Text(_sections[index]),
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(index);
                    },
                  ),
                ),
              ],
            ),
          )
              : null,
          body: RawScrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            thickness: 8.0,
            radius: const Radius.circular(4.0),
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(), // Smooth scrolling
              child: Column(
                children: [
                  // Hero Section
                  SectionContainer(
                    key: _sectionKeys[0],
                    child: const HeroSection(),
                  ),

                  // About Section
                  SectionContainer(
                    key: _sectionKeys[1],
                    child: AboutSection(isDarkMode: widget.isDarkMode),
                  ),

                  // Projects Section
                  SectionContainer(
                    key: _sectionKeys[2],
                    child: ProjectsSection(isDarkMode: widget.isDarkMode),
                  ),

                  // Contact Section
                  SectionContainer(
                    key: _sectionKeys[3],
                    child: ContactSection(isDarkMode: widget.isDarkMode),
                  ),

                  // Footer
                  FooterSection(isDarkMode: widget.isDarkMode),
                ],
              ),
            ),
          ),
          floatingActionButton: _showScrollToTop
              ? FloatingActionButton(
            onPressed: () {
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: const Icon(Icons.arrow_upward),
          )
              : null,
        ),
      ),
    );
  }
}

class SectionContainer extends StatelessWidget {
  final Widget child;

  const SectionContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightForFinite(
        width: double.infinity,
        height: double.infinity,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveValue<double>(
          context,
          defaultValue: 24.0,
          conditionalValues: [
            const Condition.largerThan(name: MOBILE, value: 48.0),
            const Condition.largerThan(name: TABLET, value: 80.0),
          ],
        ).value,
        vertical: 48.0,
      ),
      child: child,
    );
  }
}

class NavBarItem extends StatefulWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const NavBarItem({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: widget.isActive || _isHovering
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface,
                  fontWeight:
                  widget.isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: widget.isActive || _isHovering ? 20 : 0,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  final bool isDarkMode;

  const FooterSection({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          const SectionDivider(title: 'Connect'),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialIcon(
                icon: FontAwesomeIcons.github,
                onTap: () => launchURL('https://github.com/yourusername'),
                isDarkMode: isDarkMode,
              ),
              SocialIcon(
                icon: FontAwesomeIcons.linkedin,
                onTap: () => launchURL('https://linkedin.com/in/yourprofile'),
                isDarkMode: isDarkMode,
              ),
              SocialIcon(
                icon: FontAwesomeIcons.envelope,
                onTap: () => launchURL('mailto:your.email@example.com'),
                isDarkMode: isDarkMode,
              ),
              SocialIcon(
                icon: FontAwesomeIcons.twitter,
                onTap: () => launchURL('https://twitter.com/yourusername'),
                isDarkMode: isDarkMode,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '© ${DateTime.now().year} | Created with Flutter',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class SocialIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDarkMode;

  const SocialIcon({
    super.key,
    required this.icon,
    required this.onTap,
    required this.isDarkMode,
  });

  @override
  State<SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<SocialIcon> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _isHovering
                ? theme.colorScheme.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: FaIcon(
            widget.icon,
            color: _isHovering
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}