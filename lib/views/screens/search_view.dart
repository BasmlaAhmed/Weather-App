import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_api/data/services/weather_api_factory.dart';
import 'package:weather_app_api/viewmodel/cubit/weather_cubit.dart';
import 'package:weather_app_api/views/screens/weather_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF74ABE2),
        centerTitle: true,
        title: Text(
          "Weather",
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 30.w,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.all(10),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    cursorColor: Color(0xFF5588C8),
                    cursorWidth: 1.5,
                    cursorHeight: 20,
                    controller: textController,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.language_rounded,
                        color: Color(0xFF74ABE2),
                      ),
                      hintText: "Enter city name...",
                      hintStyle: GoogleFonts.montserrat(
                        color: Colors.black54,
                        fontSize: 18.w,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 227, 243, 255),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  InkWell(
                    onTap: () {
                      String city = textController.text.trim();
                      if (city.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => BlocProvider(
                                  create:
                                      (context) =>
                                          WeatherCubit(((WeatherApiFactory()))),
                                  child: WeatherView(cityName: city),
                                ),
                          ),
                        );
                        textController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Please enter a valid city name",
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.redAccent.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Color(0xFF74ABE2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.search, color: Colors.white, size: 18),
                            Text(
                              "Search",
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 20.w,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
