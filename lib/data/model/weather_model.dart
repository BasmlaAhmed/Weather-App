class WeatherModel {
  Location location;
  Current current;
  Forecast forecast;

  WeatherModel({required this.location, required this.current, required this.forecast});
  factory WeatherModel.fromJson(Map<String, dynamic> jsonWeather) {
    return WeatherModel(
      current: Current.fromJson(jsonWeather['current']),
      location: Location.fromJson(jsonWeather['location']),
      forecast: Forecast.fromJson(jsonWeather['forecast']['forecastday'][0]['day'])
    );
  }
}

class Current {
  double tempC;
  double tempF;
  Condition condition;

  Current({required this.tempC, required this.tempF, required this.condition});

  factory Current.fromJson(Map<String, dynamic> jsonCurrent) {
    return Current(
      condition: Condition.fromJson(jsonCurrent['condition']),
      tempC: (jsonCurrent['temp_c'] as num).toDouble(),
      tempF: (jsonCurrent['temp_f'] as num).toDouble(),
    );
  }
}

class Condition {
  String text;
  String icon;
  int code;

  Condition({required this.text, required this.icon, required this.code});

  factory Condition.fromJson(Map<String, dynamic> jsoncondition) {
    return Condition(
      code: jsoncondition['code'],
      icon: jsoncondition['icon'],
      text: jsoncondition['text'],
    );
  }
}

class Location {
  String name;
  String country;

  Location({required this.name, required this.country});
  factory Location.fromJson(Map<String, dynamic> jsonLocation) {
    return Location(
      country: jsonLocation['country'],
      name: jsonLocation['name'],
    );
  }
}

class Forecast {
  final double maxTempC;
  final double minTempC;

  Forecast({required this.maxTempC, required this.minTempC});

  factory Forecast.fromJson(Map<String, dynamic> jsonForecast) {
    return Forecast(
      maxTempC: (jsonForecast['maxtemp_c'] as num).toDouble(),
      minTempC: (jsonForecast['mintemp_c'] as num).toDouble(),
    );
  }
}
