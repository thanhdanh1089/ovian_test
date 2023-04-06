import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

// ignore: must_be_immutable
class MyToggleSwitch extends StatefulWidget {
  Function(bool) switched;
  final bool initial;

  MyToggleSwitch({
    Key? key,
    required this.switched,
    required this.initial,
  }) : super(key: key);

  @override
  State<MyToggleSwitch> createState() => _MyToggleSwitchState();
}

class _MyToggleSwitchState extends State<MyToggleSwitch> {
  late bool _switched;

  @override
  void initState() {
    super.initState();
    _switched = widget.initial;
  }

  //this is if you drag the switch
  _changedTo(bool switchState) {
    setState(() {
      _switched = switchState;
      widget.switched(switchState);
    });
  }

  //if you tap the switch itself;
  _onTap() {
    setState(() {
      _switched = !_switched;
      widget.switched(_switched);
    });
  }

  @override
  Widget build(BuildContext context) {
    const double height = 24.0;
    const double toggleMargin = 2.0;

    return SizedBox(
      height: height,
      child: CustomAnimatedToggleSwitch<bool>(
        current: _switched,
        values: const [false, true],
        dif: 0.0,
        indicatorSize: const Size.square(height),
        animationDuration: const Duration(milliseconds: 200),
        animationCurve: Curves.linear,
        onChanged: (b) => setState(() => _changedTo(b)),
        iconBuilder: (context, local, global) {
          return const SizedBox();
        },
        defaultCursor: SystemMouseCursors.click,
        onTap: _onTap,
        iconsTappable: false,
        wrapperBuilder: (context, global, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  left: 0.0,
                  right: 0.0,
                  height: height,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color.lerp(Color.fromARGB(66, 209, 206, 206),
                          Colors.amber, global.position),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(42.0)),
                    ),
                  )),
              child,
            ],
          );
        },
        foregroundIndicatorBuilder: (context, global) {
          return const SizedBox(
            child: Padding(
              padding: EdgeInsets.all(toggleMargin),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 100, 104, 112),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
