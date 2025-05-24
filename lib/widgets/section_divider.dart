import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SectionDivider extends StatelessWidget {
  final String title;
  final double width;
  final Color? color;
  final TextStyle? titleStyle;
  final bool isScrollable;
  final Duration animationDelay;

  const SectionDivider({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.color,
    this.titleStyle,
    this.isScrollable = true,
    this.animationDelay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = titleStyle ??
        theme.textTheme.headlineMedium?.copyWith(
          color: color ?? theme.textTheme.headlineMedium?.color,
          fontWeight: FontWeight.bold,
        );

    final Widget divider = Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  (color ?? theme.textTheme.headlineMedium?.color)?.withOpacity(0.1) ?? Colors.black,
                  (color ?? theme.textTheme.headlineMedium?.color)?.withOpacity(0.8) ?? Colors.black,
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: style,
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  (color ?? theme.textTheme.headlineMedium?.color)?.withOpacity(0.8) ?? Colors.black,
                  (color ?? theme.textTheme.headlineMedium?.color)?.withOpacity(0.1) ?? Colors.black,
                ],
              ),
            ),
          ),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: isScrollable
          ? divider
              .animate(delay: animationDelay)
              .fadeIn(duration: 800.ms, curve: Curves.easeOutQuint)
              .slideY(
                  begin: 0.2,
                  end: 0,
                  duration: 800.ms,
                  curve: Curves.easeOutQuint)
          : divider,
    );
  }
}
