import 'package:chrome_tabs/theme/colors.dart';
import 'package:flutter/material.dart';

class TabContainer extends StatefulWidget {
  final Widget child;
  final Color color;
  final VoidCallback onTap;
  final bool isCurrentTab, hideLeftAngle;
  const TabContainer(
      {required this.child,
      required this.color,
      required this.onTap,
      required this.isCurrentTab,
      required this.hideLeftAngle,
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
        painter:
            TabContainerPainter(tabColor ?? widget.color, widget.hideLeftAngle),
        child: widget.child,
      ),
    );
  }
}

class TabContainerPainter extends CustomPainter {
  final Color color;
  final bool hideLeftAngle;
  TabContainerPainter(this.color, this.hideLeftAngle);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round;
    final path = Path();
    path.moveTo(8, 0);
    path.lineTo(size.width - 8, 0);
    path.quadraticBezierTo(size.width, .5, size.width, 8);
    path.lineTo(size.width, size.height - 8);
    path.quadraticBezierTo(
        size.width, size.height - .5, size.width + 8, size.height);
    if (hideLeftAngle) {
      path.lineTo(8, size.height);
      path.quadraticBezierTo(0, size.height - .5, 0, size.height - 8);
    } else {
      path.lineTo(-8, size.height);
      path.quadraticBezierTo(0, size.height - .5, 0, size.height - 8);
    }
    path.lineTo(0, 8);
    path.quadraticBezierTo(0, .5, 8, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
