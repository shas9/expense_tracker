import 'package:flutter/material.dart';

// A custom clipper to create the diagonal split background.
class DiagonalSplitClipper extends CustomClipper<Path> {
  final double splitX;
  final double diagonalWidth;

  DiagonalSplitClipper({required this.splitX, this.diagonalWidth = 40.0});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Top-left corner
    path.lineTo(splitX + (diagonalWidth / 2), 0); // Point on top edge
    path.lineTo(splitX - (diagonalWidth / 2), size.height); // Point on bottom edge
    path.lineTo(0, size.height); // Bottom-left corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    if (oldClipper is DiagonalSplitClipper) {
      return oldClipper.splitX != splitX ||
          oldClipper.diagonalWidth != diagonalWidth;
    }
    return true;
  }
}

// A custom painter for the small triangle on top of the balance card.
class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    path.moveTo(size.width / 2, 0); // Top center
    path.lineTo(0, size.height); // Bottom left
    path.lineTo(size.width, size.height); // Bottom right
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}