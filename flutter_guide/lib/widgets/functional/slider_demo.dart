import 'package:flutter/material.dart';

///
/// desc:
///

class SliderDemo extends StatefulWidget {
  @override
  _SliderDemoState createState() => _SliderDemoState();
}

class _SliderDemoState extends State<SliderDemo> {
  double _sliderValue = 0;

  RangeValues _rangeValues = RangeValues(0, 25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('值：$_sliderValue'),

            RangeSlider(
              values: _rangeValues,
              labels: RangeLabels('${_rangeValues.start}','${_rangeValues.end}'),
              min: 0,
              max: 100,
              divisions: 4,
              onChanged: (v) {
                setState(() {
                  _rangeValues = v;
                });
              },
            ),

//            SliderTheme(
//              data: SliderTheme.of(context).copyWith(
//                valueIndicatorShape: RectangularSliderValueIndicatorShape(),
//              ),
//              child: Slider(
//                value: _sliderValue,
//                label: '$_sliderValue',
//                min: 0,
//                max: 100,
//                divisions: 4,
//                onChanged: (v) {
//                  setState(() {
//                    _sliderValue = v;
//                  });
//                },
//              ),
//            )
          ],
        ),
      ),
    );
  }
}
