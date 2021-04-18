import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_ui/components/fragments/widgets/error_widget.dart';
import 'package:weather_ui/components/fragments/widgets/loading_widget.dart';
import 'package:weather_ui/models/weather_model.dart';
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
  DateTime dateTime = DateTime.now();

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
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '${weatherData.current.temp}\u2103',
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

class WeatherConditionWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final weatherProvider = watch(weatherVm);
    final WeatherData weatherData = weatherProvider.weatherData;

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
                  TextSpan(
                      text: '${weatherData.current.feelsLike}\u2103\t\t\t',
                      style: WStyles.subtitleStyle),
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
                  '${weatherData.current.humidity}',
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
                  '${weatherData.current.windSpeed}km/h',
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
                  '${weatherData.current.uvi}',
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
