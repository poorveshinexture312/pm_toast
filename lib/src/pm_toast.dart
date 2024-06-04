import 'package:flutter/material.dart';

/// Enum representing the position of the toast message on the screen.
enum ToastPosition { top, center, bottom }

/// A customizable toast message widget.
///
/// The [PMToast] class provides a way to display temporary messages to the user
/// in a customizable toast format. It supports optional images and buttons.
class PMToast {
  /// The build context to show the toast in.
  final BuildContext context;

  /// The message to be displayed in the toast.
  final String message;

  /// The duration for which the toast is displayed.
  final Duration duration;

  /// The background color of the toast.
  final Color backgroundColor;

  /// The color of the text in the toast.
  final Color textColor;

  /// The font size of the text in the toast.
  final double fontSize;

  /// The position of the toast on the screen.
  final ToastPosition position;

  /// The border radius of the toast container.
  final BorderRadius borderRadius;

  /// The padding inside the toast container.
  final EdgeInsets padding;

  /// An optional image to be displayed on the left side of the toast.
  final Widget? leftImage;

  /// An optional button to be displayed on the left side of the toast.
  final Widget? leftButton;

  /// An optional button to be displayed on the right side of the toast.
  final Widget? rightButton;

  /// A callback function to be called when the right button is pressed.
  final VoidCallback? onRightButtonPressed;

  /// A callback function to be called when the left button is pressed.
  final VoidCallback? onLeftButtonPressed;

  /// Creates a [PMToast] instance with customizable options.
  ///
  /// The [context] and [message] parameters are required.
  /// Other parameters have default values, but can be overridden.
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

  /// Shows the toast message.
  ///
  /// This method inserts an overlay entry into the [context] overlay,
  /// displaying the toast for the specified [duration].
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
            topPosition = MediaQuery.of(context).size.height * 0.4;
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

    overlay.insert(overlayEntry);
    Future.delayed(duration, () => overlayEntry.remove());
  }

  /// Builds the widget representing the toast message.
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