import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_ui/values/providers.dart';

class WErrorWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final weatherProvider = watch(weatherVm);

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Error fetching weather details'),
          SizedBox(height: 10),
          TextButton.icon(
              onPressed: () {
                weatherProvider.getCurrentLocation(context);
              },
              icon: Icon(Icons.refresh),
              label: Text('Try again'))
        ],
      ),
    );
  }
}
