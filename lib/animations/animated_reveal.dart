import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedRevealText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final TextAlign textAlign;

  const AnimatedRevealText({
    super.key,
    required this.text,
    this.style,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 1500),
    this.curve = Curves.easeInOut,
    this.textAlign = TextAlign.start,
  });

  @override
  State<AnimatedRevealText> createState() => _AnimatedRevealTextState();
}

class _AnimatedRevealTextState extends State<AnimatedRevealText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    // Start animation after delay
    if (widget.delay == Duration.zero) {
      _isReady = true;
      _controller.forward();
    } else {
      Timer(widget.delay, () {
        if (mounted) {
          setState(() {
            _isReady = true;
          });
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: _animation.value,
            child: Text(
              widget.text,
              style: widget.style,
              textAlign: widget.textAlign,
            ),
          ),
        );
      },
    );
  }
}

class AnimatedRevealItems extends StatefulWidget {
  final List<Widget> children;
  final Duration staggerDelay;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const AnimatedRevealItems({
    super.key,
    required this.children,
    this.staggerDelay = const Duration(milliseconds: 200),
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  State<AnimatedRevealItems> createState() => _AnimatedRevealItemsState();
}

class _AnimatedRevealItemsState extends State<AnimatedRevealItems>
    with TickerProviderStateMixin {
  // List to keep track of all animation controllers
  final List<AnimationController> _controllers = [];

  @override
  void dispose() {
    // Dispose all animation controllers
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: List.generate(
        widget.children.length,
        (index) {
          final child = widget.children[index];
          final delay = Duration(
            milliseconds: widget.staggerDelay.inMilliseconds * index,
          );

          return FadeTransition(
            opacity: _createAnimation(delay),
            child: SlideTransition(
              position: _createSlideAnimation(delay),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }

  Animation<double> _createAnimation(Duration delay) {
    // Ensure weight is always positive
    final delayWeight = delay.inMilliseconds > 0 ? delay.inMilliseconds / 1000 : 0.01;
    
    final controller = AnimationController(
      vsync: this,
      duration: delay + const Duration(milliseconds: 800),
    );
    
    // Add controller to the list for disposal later
    _controllers.add(controller);
    
    controller.forward();
    
    return TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.0).chain(
          CurveTween(curve: Curves.easeInOut),
        ),
        weight: delayWeight,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: Curves.easeInOut),
        ),
        weight: 1.0,
      ),
    ]).animate(controller);
  }

  Animation<Offset> _createSlideAnimation(Duration delay) {
    // Ensure weight is always positive
    final delayWeight = delay.inMilliseconds > 0 ? delay.inMilliseconds / 1000 : 0.01;
    
    final controller = AnimationController(
      vsync: this,
      duration: delay + const Duration(milliseconds: 800),
    );
    
    // Add controller to the list for disposal later
    _controllers.add(controller);
    
    controller.forward();
    
    return TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0.0, 0.5),
          end: const Offset(0.0, 0.5),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: delayWeight,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0.0, 0.5),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutQuint)),
        weight: 1.0,
      ),
    ]).animate(controller);
  }
}
