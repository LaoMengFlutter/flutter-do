import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import './fluid_icon.dart';
import './curves.dart';

typedef void FluidNavBarButtonPressedCallback();

class FluidNavBarButton extends StatefulWidget {
  static const nominalExtent = const Size(64, 64);

  final Widget _icon;
  final Widget _activeIcon;
  final Widget _title;
  final bool _selected;
  final FluidNavBarButtonPressedCallback _onPressed;

  FluidNavBarButton(Widget icon, Widget activeIcon,Widget title, bool selected,
      FluidNavBarButtonPressedCallback onPressed)
      : _icon = icon,
        _activeIcon = activeIcon,
        _title = title,
        _selected = selected,
        _onPressed = onPressed;

  @override
  State createState() => _FluidNavBarButtonState(_selected);
}

class _FluidNavBarButtonState extends State<FluidNavBarButton>
    with SingleTickerProviderStateMixin {
  static const double _activeOffset = 16;
  static const double _defaultOffset = 0;
  static const double _radius = 25;

  bool _selected;

  _FluidNavBarButtonState(this._selected);

  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1666),
        reverseDuration: const Duration(milliseconds: 833),
        vsync: this);
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _startAnimation();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    const ne = FluidNavBarButton.nominalExtent;
    final offsetCurve =
        widget._selected ? ElasticOutCurve(0.38) : Curves.easeInQuint;
    final scaleCurve = widget._selected
        ? CenteredElasticOutCurve(0.6)
        : CenteredElasticInCurve(0.6);

    final progress = LinearPointCurve(0.28, 0.0).transform(_animation.value);

    final offset = Tween<double>(begin: _defaultOffset, end: _activeOffset)
        .transform(offsetCurve.transform(progress));
    final scaleCurveScale = 0.50;
    final scaleY = 0.5 +
        scaleCurve.transform(progress) * scaleCurveScale +
        (0.5 - scaleCurveScale / 2);

    // Create a parameterizable flat button with a fluid fill icon
    return GestureDetector(
      // We wan't to know when this button was tapped, don't bother letting out children know as well
      onTap: widget._onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        // Alignment container to the circle
        constraints: BoxConstraints.tight(ne),
        alignment: Alignment.center,
        child: Container(
          // This container just draws a circle with a certain radius and offset
          margin: EdgeInsets.all(ne.width / 2 - _radius),
          constraints: BoxConstraints.tight(Size.square(_radius * 2)),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: CircleBorder(),
          ),
          transform: Matrix4.translationValues(0, -offset, 0),
          // Create a fluid fill icon that get's filled in with a slight delay to the buttons animation
          child: widget._selected
              ? widget._activeIcon
              : Column(
                  children: <Widget>[
                    widget._icon,
                    widget._title,
                  ],
                ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(oldWidget) {
    setState(() {
      _selected = widget._selected;
    });
    _startAnimation();
    super.didUpdateWidget(oldWidget);
  }

  void _startAnimation() {
    if (_selected) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}
