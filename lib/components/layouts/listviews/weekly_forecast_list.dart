import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_ui/models/weather_model.dart';
import 'package:weather_ui/style/textstyle.dart';
import 'package:weather_ui/values/providers.dart';

class WeeklyForcastList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final weatherProvider = watch(weatherVm);
    List<Daily> weeklyForcastList = weatherProvider.weatherData.daily;

    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 5),
      itemCount: weeklyForcastList.length,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final Daily item = weeklyForcastList[index];
        final String date =
            Jiffy(DateTime.fromMillisecondsSinceEpoch(item.dt * 1000)).E;
        return Row(
          children: [
            Image.network(
              'https://openweathermap.org/img/w/${weeklyForcastList[index].weather.first.icon}.png',
              scale: 0.7,
            ),
            Text(
              '$date',
              style: WStyles.dayStyle,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 2,
                child: Text(
                  '${item.temp.max}\u2103/${item.temp.min}\u2103',
                  style: WStyles.tempStyle,
                )),
            Text(
              '${item.weather.first.description}',
              style: WStyles.dayStyle,
            )
          ],
        );
      },
    );
  }
}
