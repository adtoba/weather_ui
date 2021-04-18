import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_ui/components/fragments/widgets/error_widget.dart';
import 'package:weather_ui/components/fragments/widgets/loading_widget.dart';
import 'package:weather_ui/components/layouts/listviews/weekly_forecast_list.dart';
import 'package:weather_ui/models/weather_model.dart';
import 'package:weather_ui/style/colors.dart';
import 'package:weather_ui/style/textstyle.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_ui/values/providers.dart';

class WeeklyPage extends StatefulHookWidget {
  @override
  _WeeklyPageState createState() => _WeeklyPageState();
}

class _WeeklyPageState extends State<WeeklyPage> {
  final DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = useProvider(weatherVm);
    final WeatherData weatherData = weatherProvider.weatherData;

    if (weatherProvider.isLoading) {
      return LoadingWidget();
    }

    if (weatherProvider.hasError) {
      return WErrorWidget();
    }

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
                              '${weatherProvider.currentAddress}',
                              style: WStyles.locationStyle,
                            ),
                            Text(
                              '${Jiffy(dateTime).MMMEd}',
                              style: WStyles.dateStyle,
                            ),
                            SizedBox(height: 20),
                            Text(
                              '${weatherData.current.weather.first.description}'
                                  .toUpperCase(),
                              style: WStyles.conditionStyle,
                            )
                          ],
                        ),
                      ),
                      Image.network(
                        'https://openweathermap.org/img/w/${weatherData.current.weather.first.icon}.png',
                        color: WColors.white,
                        scale: 0.7,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '${weatherData.current.temp}\u2103',
                    style: WStyles.temperatureStyle,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: WeeklyForcastList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
