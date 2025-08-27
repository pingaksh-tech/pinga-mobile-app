import 'package:flutter/material.dart';

class FetchWidgetSize extends StatelessWidget {
  final Widget child;
  final Function(Size size) getSize;

  const FetchWidgetSize({
    required this.child,
    required this.getSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      getSize(renderBox.size);
    });

    return child;
  }
} /*import 'package:flutter/material.dart';

class FetchWidgetSize extends StatefulWidget {
  final Function(Size size)? getSize;
  final Widget child;
  final bool fetchContinuously; // Added flag for continuous fetching

  const FetchWidgetSize({
    super.key,
    this.getSize,
    required this.child,
    this.fetchContinuously = false, // Default to single fetch
  });

  @override
  State<FetchWidgetSize> createState() => _FetchWidgetSizeState();
}

class _FetchWidgetSizeState extends State<FetchWidgetSize> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // After the build phase, get the size of the widget and set it to the first widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final size = renderBox.size;
      setState(() {
        widget.getSize != null ? widget.getSize!(size) : null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
*/
