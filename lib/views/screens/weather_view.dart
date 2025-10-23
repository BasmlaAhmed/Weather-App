import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_api/viewmodel/cubit/weather_cubit.dart';
import 'package:weather_app_api/viewmodel/cubit/weather_state.dart';

class WeatherView extends StatefulWidget {
  final String cityName;
  const WeatherView({super.key, required this.cityName});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().getData(widget.cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 183, 219, 255), Color(0xFF5588C8)],
          ),
        ),
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial || state is WeatherLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (state is WeatherFailure) {
              return Center(child: Text("Error: ${state.errorMsg}"));
            } else if (state is WeatherSuccess) {
              final weather = state.weatherData;
              final iconURL =
                  weather.current.condition.icon.startsWith("https")
                      ? weather.current.condition.icon
                      : "https:${weather.current.condition.icon}";
              return SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${weather.location.name}, ${weather.location.country}",
                          style: GoogleFonts.montserrat(
                            fontSize: 48.w,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Image.network(iconURL, width: 100.w),
                        SizedBox(height: 5.h),
                        Text(
                          weather.current.condition.text,
                          style: GoogleFonts.montserrat(
                            fontSize: 25.w,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.montserrat(
                              fontSize: 40.w,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: "High: ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text:
                                    "${weather.forecast.maxTempC.toStringAsFixed(0)}°C\n",
                                style: TextStyle(fontWeight: FontWeight.w100),
                              ),
                              TextSpan(
                                text: "Low: ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text:
                                    " ${weather.forecast.minTempC.toStringAsFixed(0)}°C",
                                style: TextStyle(fontWeight: FontWeight.w100),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          icon: Icon(
                            Icons.language,
                            color: Color.fromARGB(255, 97, 163, 216),
                          ),
                          label: Text(
                            "Search for another city",
                            style: GoogleFonts.montserrat(
                              fontSize: 17.w,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 97, 163, 216),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center();
            }
          },
        ),
      ),
    );
  }
}
