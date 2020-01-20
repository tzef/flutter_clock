// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:analog_clock/HandsAngelData/weatherClockHandAnglesData.dart';
import 'package:analog_clock/GroupsClock/numeric_clock_model.dart';
import 'package:analog_clock/GroupsClock/numeric_group_clock.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' show radians;
import 'package:analog_clock/compositional_clock.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'GroupsClock/small_numeric_group_clock.dart';
import 'GroupsClock/colon_group_clock.dart';
import 'GroupsClock/dot_group_clock.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

final singleClockSize = 30.0;
final clockCanvasSize = Size(615, 375);

class AnalogClock extends StatefulWidget {
  const AnalogClock(this.model);

  final ClockModel model;

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> with SingleTickerProviderStateMixin {
  var _temperatureRange = '';
  var _temperature = '';
  var _condition = '';
  var _location = '';

  NumericGroupClock numberClock1 = NumericGroupClock(singleSize: singleClockSize, model: NumericClockModel("0"));
  NumericGroupClock numberClock2 = NumericGroupClock(singleSize: singleClockSize, model: NumericClockModel("0"));
  NumericGroupClock numberClock3 = NumericGroupClock(singleSize: singleClockSize, model: NumericClockModel("0"));
  NumericGroupClock numberClock4 = NumericGroupClock(singleSize: singleClockSize, model: NumericClockModel("0"));
  ColonGroupClock colonClock = ColonGroupClock(singleSize: singleClockSize, model: NumericClockModel(":"));
  CompositionalClock secondsClock = CompositionalClock(radius: 40, clockNumber: null, model: CompositionalClockModel(null));
  SmallNumericGroupClock smallNumberClock1 = SmallNumericGroupClock(singleSize: singleClockSize, model: NumericClockModel("0"));
  SmallNumericGroupClock smallNumberClock2 = SmallNumericGroupClock(singleSize: singleClockSize, model: NumericClockModel("0"));
  SmallNumericGroupClock smallNumberClock3 = SmallNumericGroupClock(singleSize: singleClockSize, model: NumericClockModel("0"));

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    widget.model.addListener(_updateModel);
    secondsClock.model.oneMinutesCompletion = displayTime;
    secondsClock.model.fifteenSecondsCompletion = () {
      displayWeather();
    };
    secondsClock.model.twentyCompletion = () {
      displayTime();
    };
    secondsClock.model.thirtyCompletion = () {
      displayWeather();
    };
    secondsClock.model.thirtyFiveCompletion = () {
      displayTime();
    };
    secondsClock.model.fortyFiveCompletion = () {
      displayWeather();
    };
    secondsClock.model.fiftyFiveCompletion = () {
      displayTime();
    };
    secondsClock.model.notifyListeners();
    _updateModel();
    displayTime();
  }

  @override
  void didUpdateWidget(AnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void displayTime() {
    var _now = DateTime.now();
    var hour = DateFormat("HH").format(_now);
    if (hour.length == 2) {
      numberClock1.model.key = hour.substring(0, 1);
      numberClock2.model.key = hour.substring(1, 2);
    }
    var minute = DateFormat("mm").format(_now);
    if (minute.length == 2) {
      numberClock3.model.key = minute.substring(0, 1);
      numberClock4.model.key = minute.substring(1, 2);
    }
    colonClock.model.key = ":";
    numberClock1.model.notifyListeners();
    numberClock2.model.notifyListeners();
    colonClock.model.notifyListeners();
    numberClock3.model.notifyListeners();
    numberClock4.model.notifyListeners();
  }

  void displayWeather() {
    if (weatherHandAngles["${_condition}_1"] != null) {
      numberClock1.model.key = "${_condition}_1";
      numberClock2.model.key = "${_condition}_2";
      colonClock.model.key = "${_condition}_3";
      numberClock3.model.key = "${_condition}_4";
      numberClock4.model.key = "${_condition}_5";
      numberClock1.model.notifyListeners();
      numberClock2.model.notifyListeners();
      colonClock.model.notifyListeners();
      numberClock3.model.notifyListeners();
      numberClock4.model.notifyListeners();
    }
  }

  void _updateModel() {
    setState(() {
      _temperatureRange = '(${widget.model.low} - ${widget.model.highString})';
      _temperature = widget.model.temperatureString;
      _condition = widget.model.weatherString;
      _location = widget.model.location;
      var tempratureCharactors = _temperature.split(".");
      if (tempratureCharactors.length == 2) {
        if (tempratureCharactors[0].length == 1) {
          smallNumberClock1.model.key = "0";
          smallNumberClock2.model.key = tempratureCharactors[0].substring(0, 1);
        } else if (tempratureCharactors[0].length > 1) {
          smallNumberClock1.model.key = tempratureCharactors[0].substring(tempratureCharactors[0].length - 2, tempratureCharactors[0].length - 1);
          smallNumberClock2.model.key = tempratureCharactors[0].substring(tempratureCharactors[0].length - 1, tempratureCharactors[0].length);
        }
        if (tempratureCharactors[1].length > 0) {
          smallNumberClock3.model.key = tempratureCharactors[1].substring(0, 1);
        }
        smallNumberClock1.model.notifyListeners();
        smallNumberClock2.model.notifyListeners();
        smallNumberClock3.model.notifyListeners();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
            primaryColor: Color(0xFF4285F4),
            highlightColor: Color(0xFF8AB4F8),
            accentColor: Color(0xFF669DF6),
            backgroundColor: Color(0xFFD2E3FC),
          )
        : Theme.of(context).copyWith(
            primaryColor: Color(0xFFD2E3FC),
            highlightColor: Color(0xFF4285F4),
            accentColor: Color(0xFF8AB4F8),
            backgroundColor: Color(0xFF3C4043),
          );

    final time = DateFormat.Hms().format(DateTime.now());
    final weatherInfo = DefaultTextStyle(
      style: TextStyle(color: customTheme.primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_temperature),
          Text(_temperatureRange),
          Text(_condition),
          Text(_location),
        ],
      ),
    );

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time $time',
        value: time,
      ),
      child: Container(
        color: customTheme.backgroundColor,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: clockCanvasSize.width,
                height: clockCanvasSize.height,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[numberClock1, numberClock2, colonClock, numberClock3, numberClock4],
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Container(width: (singleClockSize + 4) * 4),
                          smallNumberClock1,
                          smallNumberClock2,
                          DotGroupClock(singleSize: singleClockSize),
                          smallNumberClock3,
                          SmallNumericGroupClock(singleSize: singleClockSize, model: NumericClockModel("o")),
                          SmallNumericGroupClock(singleSize: singleClockSize, model: NumericClockModel("C")),
                          Container(
                            width: 100,
                            height: 40,
                            child: secondsClock,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 16,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: weatherInfo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
