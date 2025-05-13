import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
        theme.colorScheme.surface.withOpacity(0.2);

    return MouseRegion(
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
          duration: 350.milliseconds,
          curve: Curves.easeOutQuint,
          margin: widget.margin,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovering ? -8.0 : 0.0, 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: widget.blur,
                sigmaY: widget.blur,
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
                      background.withOpacity(0.1),
                      background.withOpacity(0.2),
                    ],
                  ),
                  border: Border.all(
                    width: 1.5,
                    color: widget.borderColor.withOpacity(_isHovering ? 0.8 : 0.3),
                  ),
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
    );
  }
}
