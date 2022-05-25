import 'package:chrome_tabs/theme/colors.dart';
import 'package:flutter/material.dart';

class TabContainer extends StatefulWidget {
  final Widget child;
  final Color color;
  final VoidCallback onTap;
  final bool isCurrentTab;
  const TabContainer(
      {required this.child,
      required this.color,
      required this.onTap,
      required this.isCurrentTab,
      super.key});

  @override
  State<TabContainer> createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  Color? tabColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (isHovered) {
        if (widget.isCurrentTab) return;
        if (isHovered) tabColor = AppColors.highlightColor;
        if (!isHovered) tabColor = null;
        setState(() {});
      },
      mouseCursor: !widget.isCurrentTab
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onTap: () {
        widget.onTap();
        tabColor = null;
        setState(() {});
      },
      child: CustomPaint(
        painter: TabContainerPainter(tabColor ?? widget.color),
        child: widget.child,
      ),
    );
  }
}

class TabContainerPainter extends CustomPainter {
  final Color color;
  TabContainerPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round;
    final path = Path();
    path.moveTo(10, 0);
    path.lineTo(size.width - 15, 0);
    path.quadraticBezierTo(size.width, 2, size.width, 15);
    path.lineTo(size.width, size.height - 10);
    path.quadraticBezierTo(
        size.width, size.height - 5, size.width + 15, size.height);
    path.lineTo(-15, size.height);
    path.quadraticBezierTo(0, size.height - 5, 0, size.height - 15);
    path.lineTo(0, 15);
    path.quadraticBezierTo(0, 2, 15, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
