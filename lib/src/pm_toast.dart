import 'package:flutter/material.dart';

enum ToastPosition { top, center, bottom }

class PMToast {
  final BuildContext context;
  final String message;
  final Duration duration;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final ToastPosition position;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final Widget? leftImage;
  final Widget? leftButton;
  final Widget? rightButton;
  final VoidCallback? onRightButtonPressed;
  final VoidCallback? onLeftButtonPressed;

  PMToast({
    required this.context,
    required this.message,
    this.duration = const Duration(seconds: 2),
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.position = ToastPosition.bottom,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    this.leftImage,
    this.leftButton,
    this.rightButton,
    this.onRightButtonPressed,
    this.onLeftButtonPressed,
  });

  void show() {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        double topPosition;
        switch (position) {
          case ToastPosition.top:
            topPosition = MediaQuery.of(context).size.height * 0.1;
            break;
          case ToastPosition.center:
            topPosition =
                MediaQuery.of(context).size.height * 0.4; // Adjust as needed
            break;
          case ToastPosition.bottom:
            topPosition = MediaQuery.of(context).size.height * 0.9;
            break;
        }

        return Positioned(
          top: topPosition,
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1,
          child: Material(
            color: Colors.transparent,
            child: _buildToastWidget(),
          ),
        );
      },
    );

    overlay?.insert(overlayEntry);
    Future.delayed(duration, () => overlayEntry.remove());
  }

  Widget _buildToastWidget() {
    return Center(
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leftImage != null) ...[
              leftImage!,
              const SizedBox(width: 8.0),
            ],
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: textColor, fontSize: fontSize),
              ),
            ),
            if (leftButton != null) ...[
              const SizedBox(width: 8.0),
              GestureDetector(
                onTap: onLeftButtonPressed,
                child: leftButton!,
              ),
            ],
            if (rightButton != null) ...[
              const SizedBox(width: 8.0),
              GestureDetector(
                onTap: onRightButtonPressed,
                child: rightButton!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
