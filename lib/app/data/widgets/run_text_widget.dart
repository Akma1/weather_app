import 'package:flutter/material.dart';

class RunTextWidget extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;
  final ScrollPhysics? physics;
  final bool isRunning;

  const RunTextWidget({
    Key? key,
    required this.child,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 6000),
    this.backDuration = const Duration(milliseconds: 800),
    this.pauseDuration = const Duration(milliseconds: 800),
    this.physics,
    this.isRunning = true,
  }) : super(key: key);

  @override
  RunTextWidgetState createState() => RunTextWidgetState();
}

class RunTextWidgetState extends State<RunTextWidget> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: widget.physics,
      scrollDirection: widget.direction,
      controller: scrollController,
      child: widget.child,
    );
  }

  void scroll(_) async {
    if (widget.isRunning == true) {
      while (scrollController.hasClients) {
        await Future.delayed(widget.pauseDuration);
        if (scrollController.hasClients) {
          await scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: widget.animationDuration,
            curve: Curves.ease,
          );
        }
        await Future.delayed(widget.pauseDuration);
        if (scrollController.hasClients) {
          await scrollController.animateTo(
            0.0,
            duration: widget.backDuration,
            curve: Curves.easeOut,
          );
        }
      }
    }
  }
}
