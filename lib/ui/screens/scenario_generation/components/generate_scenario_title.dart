import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenerateScenarioTitle extends StatefulWidget {
  final Color backgroundColor;
  final Color iconBackgroundColor;
  final String assetPath;
  final String title;
  final String description;
  final VoidCallback? onTap;
  final Color borderColor;
  final Color? iconColor;
  final Color? textColor;

  const GenerateScenarioTitle({
    required this.description,
    required this.title,
    required this.assetPath,
    required this.backgroundColor,
    required this.iconBackgroundColor,
    this.onTap,
    this.borderColor = Colors.transparent,
    this.iconColor,
    this.textColor,
    super.key,
  });

  @override
  State<GenerateScenarioTitle> createState() => _GenerateScenarioTitleState();
}

class _GenerateScenarioTitleState extends State<GenerateScenarioTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: widget.borderColor, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(_isHovered ? 0.1 : 0.05),
                  blurRadius: 12,
                  spreadRadius: 1,
                  offset: Offset(0, _isHovered ? 4 : 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.iconBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: widget.borderColor.withOpacity(0.2),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        widget.assetPath,
                        width: 32,
                        height: 32,
                        color: widget.iconColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: widget.textColor ?? Colors.black87,
                          ),
                        ),
                        Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: (widget.textColor ?? Colors.black87)
                                .withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: widget.borderColor,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
