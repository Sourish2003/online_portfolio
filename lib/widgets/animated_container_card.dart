import 'package:flutter/material.dart';
import 'dart:ui';

class AnimatedContainerCard extends StatefulWidget {
  final Widget child;
  final double width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blur;
  final Color borderColor;
  final Color? backgroundColor;
  final double opacity;
  final bool enableHover;
  final VoidCallback? onTap;

  const AnimatedContainerCard({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height,
    this.padding = const EdgeInsets.all(20),
    this.margin,
    this.borderRadius = 20.0,
    this.blur = 10.0,
    this.borderColor = Colors.white,
    this.backgroundColor,
    this.opacity = 0.2,
    this.enableHover = true,
    this.onTap,
  });

  @override
  State<AnimatedContainerCard> createState() => _AnimatedContainerCardState();
}

class _AnimatedContainerCardState extends State<AnimatedContainerCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color background = widget.backgroundColor ??
        theme.colorScheme.surface.withValues(alpha: 0.2);

    return RepaintBoundary(
      child: MouseRegion(
        onEnter: widget.enableHover ? (_) {
          setState(() {
            _isHovering = true;
          });
        } : null,
        onExit: widget.enableHover ? (_) {
          setState(() {
            _isHovering = false;
          });
        } : null,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutQuint,
            margin: widget.margin,
            transform: Matrix4.identity()
              ..translateByDouble(0.0, _isHovering ? -6.0 : 0.0, 0.0, 1.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: widget.blur > 8 ? 8 : widget.blur,
                  sigmaY: widget.blur > 8 ? 8 : widget.blur,
                ),
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        background.withValues(alpha: 0.1),
                        background.withValues(alpha: 0.18),
                      ],
                    ),
                    border: Border.all(
                      width: 1.2,
                      color: widget.borderColor.withValues(alpha: _isHovering ? 0.7 : 0.25),
                    ),
                    boxShadow: _isHovering
                        ? [
                            BoxShadow(
                              color: theme.colorScheme.primary.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: widget.padding!,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
