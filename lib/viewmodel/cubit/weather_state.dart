import 'package:weather_app_api/data/model/weather_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSuccess extends WeatherState {
  final WeatherModel weatherData;
  WeatherSuccess(this.weatherData);
}

class WeatherFailure extends WeatherState {
  final String errorMsg;
  WeatherFailure(this.errorMsg);
}
