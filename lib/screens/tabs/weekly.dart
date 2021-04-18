import 'package:flutter/material.dart';
import 'package:weather_ui/style/colors.dart';
import 'package:weather_ui/style/textstyle.dart';

class WeeklyPage extends StatefulWidget {
  @override
  _WeeklyPageState createState() => _WeeklyPageState();
}

class _WeeklyPageState extends State<WeeklyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            color: WColors.deepBlue,
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
                              'New Delhi',
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '14c',
                    style: WStyles.temperatureStyle,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
