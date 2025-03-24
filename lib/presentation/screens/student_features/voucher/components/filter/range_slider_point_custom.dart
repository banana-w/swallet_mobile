import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class RangeSliderPointCustom extends StatefulWidget {
  const RangeSliderPointCustom({super.key});

  @override
  State<RangeSliderPointCustom> createState() => _RangeSliderPointCustomState();
}

class _RangeSliderPointCustomState extends State<RangeSliderPointCustom> {
  RangeValues _currentRangeValues = const RangeValues(0, 80);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 50, left: 50),
      child: RangeSlider(
        values: _currentRangeValues,
        activeColor: kPrimaryColor,
        max: 500,
        divisions: 5,
        labels: RangeLabels(
          _currentRangeValues.start.round().toString(),
          _currentRangeValues.end.round().toString(),
        ),
        onChanged: (RangeValues values) {
          setState(() {
            _currentRangeValues = values;
          });
        },
      ),
    );
  }
}
