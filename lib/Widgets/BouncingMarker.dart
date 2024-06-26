import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



class BouncingSvgImage extends StatefulWidget {
  final String imagePath;
  final double width;
  final double height;
  final Animation<double> animation;

  BouncingSvgImage({
    required this.imagePath,
    required this.width,
    required this.height,
    required this.animation,
  });

  @override
  _BouncingSvgImageState createState() => _BouncingSvgImageState();
}

class _BouncingSvgImageState extends State<BouncingSvgImage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -widget.animation.value),
          child: Container(
            width: widget.width,
            height: widget.height,
            child: SvgPicture.asset(widget.imagePath),
          ),
        );
      },
    );
  }
}





class ExpandableContainer extends StatefulWidget {
  final double initialHeight;
  final double maxHeight;
  final Widget child;

  const ExpandableContainer({
    Key? key,
    required this.initialHeight,
    required this.maxHeight,
    required this.child,
  }) : super(key: key);

  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  late double _height;

  @override
  void initState() {
    super.initState();
    _height = widget.initialHeight;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          _height -= details.delta.dy;
          if (_height < widget.initialHeight) {
            _height = widget.initialHeight;
          }
          if (_height > widget.maxHeight) {
            _height = widget.maxHeight;
          }
        });
      },
      onVerticalDragEnd: (details) {
        final double velocity = details.velocity.pixelsPerSecond.dy;
        if (velocity < -630) { // Expand to maxHeight with fast drag up
          setState(() {
            _height = widget.maxHeight;
          });
        } else if (velocity > 630) { // Contract to initialHeight with fast drag down
          setState(() {
            _height = widget.initialHeight;
          });
        } else { // Snap to either maxHeight or initialHeight based on current height
          final double midHeight = (widget.maxHeight + widget.initialHeight) / 2;
          setState(() {
            _height = _height < midHeight ? widget.initialHeight : widget.maxHeight;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _height,
        child: widget.child,
      ),
    );
  }
}



