import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatefulWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color contentColor;
  final Color backgroundColor;
  final double height;
  final bool isDisabled;
  final bool showBorder;
  final bool shouldBold;

  const PrimaryButtonWidget({
    super.key,
    required this.label,
    this.contentColor = Colors.white,
    this.backgroundColor = Colors.lightGreen,
    this.height = 50,
    this.isDisabled = false,
    this.showBorder = true,
    this.shouldBold = false,
    this.onPressed,
  });

  @override
  State<PrimaryButtonWidget> createState() => _PrimaryButtonWidgetState();
}

class _PrimaryButtonWidgetState extends State<PrimaryButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.isDisabled ? 0.3 : 1,
      child: SizedBox(
        width: double.infinity, // Maximum possible width
        height: widget.height,
        child: OutlinedButton(
          onPressed: widget.isDisabled ? null : widget.onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: widget.contentColor,
            backgroundColor: widget.backgroundColor,
            side: BorderSide(
              color: widget.showBorder ? Colors.white : Colors.transparent,
              width: 1.0,   
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), 
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 17,
              fontWeight: widget.shouldBold ? FontWeight.w800 : FontWeight.w600,
              color: widget.contentColor,
            ),
          ),
        ),
      ),
    );
  }
}
