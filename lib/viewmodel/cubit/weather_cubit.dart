import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_api/data/services/weather_api_factory.dart';
import 'package:weather_app_api/viewmodel/cubit/weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherApiFactory weatherApiFactory;
  WeatherCubit(this.weatherApiFactory)
    : super(WeatherInitial()); //* اول حالة هتتنفذ

  Future<void> getData(String city) async {
    try {
      emit(WeatherLoading());
      final weather = await weatherApiFactory.fetchWeather(city);
      emit(WeatherSuccess(weather));
    } catch (e) {
      emit(WeatherFailure(e.toString()));
    }
  }
}
