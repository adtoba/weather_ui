import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_ui/viewmodels/location_vm.dart';

final locationVm = ChangeNotifierProvider((ref) => LocationVm());
