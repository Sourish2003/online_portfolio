import 'package:flutter/material.dart';

class CursorAnimation extends StatefulWidget {
  final Widget child;
  final Color hoverColor;
  final Color defaultColor;
  final double size;
  final double blurRadius;

  const CursorAnimation({
    super.key,
    required this.child,
    this.hoverColor = Colors.purple,
    this.defaultColor = Colors.white,
    this.size = 20.0,
    this.blurRadius = 40.0,
  });

  @override
  State<CursorAnimation> createState() => _CursorAnimationState();
}

class _CursorAnimationState extends State<CursorAnimation> {
  Offset _mousePosition = Offset.zero;
  bool _isMouseInside = false;
  bool _isHovering = false;

  bool _isScrolling = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (event) {
        setState(() {
          _isScrolling = true;
          Future.delayed(const Duration(milliseconds: 200), () {
            if (mounted) {
              setState(() {
                _isScrolling = false;
              });
            }
          });
        });
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isMouseInside = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isMouseInside = false;
            _isHovering = false;
          });
        },
        onHover: (event) {
          setState(() {
            _mousePosition = event.localPosition;
          });
        },
        child: Stack(
          children: [
            widget.child,
            if (_isMouseInside && !_isScrolling)
              Positioned(
                left: _mousePosition.dx - widget.size / 2,
                top: _mousePosition.dy - widget.size / 2,
                child: IgnorePointer(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isHovering ? widget.hoverColor : widget.defaultColor,
                      boxShadow: [
                        BoxShadow(
                          color: _isHovering
                              ? widget.hoverColor.withValues(alpha: 0.5)
                              : widget.defaultColor.withValues(alpha: 0.5),
                          blurRadius: widget.blurRadius,
                          spreadRadius: widget.size / 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}