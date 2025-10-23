import 'package:dio/dio.dart';
import 'package:weather_app_api/data/model/weather_model.dart';

class WeatherApiFactory {
  final Dio dio = Dio();
  Future<WeatherModel> fetchWeather(String city) async {
    final response = await dio.get(
      "https://api.weatherapi.com/v1/forecast.json",
      queryParameters: {"q": city, "key": "32567b6995694b1a806185721250910"},
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.data);
    } else {
      throw Exception("status code: ${response.statusCode}");
    }
  }
}
