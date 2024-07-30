import 'package:flutter/material.dart';
import 'package:huz/TextStyles/Color.dart';

class PriceRangeSlider extends StatefulWidget {
  const PriceRangeSlider({super.key});

  @override
  State<PriceRangeSlider> createState() => _PriceRangeSliderState();
}

var startValue = 80000.0;
var endValue = 1000000.0;

class _PriceRangeSliderState extends State<PriceRangeSlider> {


  RangeValues _currentRangeValues =  RangeValues(startValue, endValue);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(


      labels:  RangeLabels( _currentRangeValues.start.round().toString(),
        _currentRangeValues.end.round().toString(),),
        activeColor: AppColors.GlobelColor,
        inactiveColor: AppColors.GlobelColor.withOpacity(0.50),
        
        max: 1000000,
        divisions: 4,
        min: 80000,
        // onChangeStart: (value){
        //   startValue = value;
        // },
        // onChangeEnd: (value){
        //   endValue = value;
        // },
        values: _currentRangeValues, onChanged: (value){
          setState(() {
            _currentRangeValues = value;
          });
    });
  }
}
