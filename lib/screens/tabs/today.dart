import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_ui/style/colors.dart';
import 'package:weather_ui/style/textstyle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weather_ui/values/providers.dart';

class TodayPage extends StatefulHookWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  void initState() {
    context.read(locationVm).getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = useProvider(locationVm);

    if (locationProvider.currentAddress == null) {
      return Container(
          alignment: Alignment.center, child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
                  elevation: 0,
                  actions: [
                    IconButton(icon: Icon(Icons.search), onPressed: () {})
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${locationProvider.currentAddress}',
                              style: WStyles.locationStyle,
                            ),
                            Text(
                              'Friday June 30',
                              style: WStyles.dateStyle,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Light rain',
                              style: WStyles.conditionStyle,
                            )
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/Wed.png',
                        color: WColors.white,
                        scale: 0.7,
                      )
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '14c',
                    style: WStyles.temperatureStyle,
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.cover)),
          ),
        ),
        Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: WeatherConditionWidget())
      ],
    );
  }
}

class WeatherConditionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/thermometer.png',
              scale: 2,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Feels like',
                  style: WStyles.titleStyle,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(text: '22c\t\t\t', style: WStyles.subtitleStyle),
                  TextSpan(text: 'Today', style: TextStyle(color: Colors.blue))
                ])),
              ],
            ),
            Spacer(),
            Image.asset(
              'assets/images/humidity.png',
              scale: 2,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Humidity',
                  style: WStyles.titleStyle,
                ),
                Text(
                  '94%',
                  style: WStyles.subtitleStyle,
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Image.asset(
              'assets/images/wind.png',
              scale: 2,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wind',
                  style: WStyles.titleStyle,
                ),
                Text(
                  '13km/h',
                  style: WStyles.subtitleStyle,
                )
              ],
            ),
            Spacer(),
            Image.asset(
              'assets/images/uv.png',
              scale: 2,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UV index',
                  style: WStyles.titleStyle,
                ),
                Text(
                  '7',
                  style: WStyles.subtitleStyle,
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
