import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
//import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _weatherService = WeatherService('API KEY HERE');
  Weather? _weather;

  _fetchweather() async {
  String cityName = await _weatherService.getCurrentCity();

  try{
    final weather = await _weatherService.getWeather(cityName);
    print(weather);
    setState(() {
      _weather = weather;
    });
  }

  catch (e) {
    print(e);
  }
  }

  String weathericon(int? weatherid){
    if (weatherid == null) return 'assets/6.png';

    int check = weatherid;

      if ( check <= 232 && check>=200 ){
        return 'assets/1.png'; 
      }

      else if ( check <= 321 && check>=300 ){
        return 'assets/2.png';
      }

      else if ( check <= 531 && check>=500 ){
        return 'assets/3.png';
      }

      else if ( check <= 622 && check>=600 ){
        return 'assets/4.png';
      }

      else if ( check <= 781 && check>=700 ){
        return 'assets/5.png';
      }

      else if ( check == 800){
        return 'assets/6.png';
      }

      else if ( check <= 804 && check>=801 ){
        return 'assets/8.png';
      }

      else{
        return 'assets/6.png';
      }

  }

  @override
  void initState() {
    super.initState();

    _fetchweather();
  }




  @override
  Widget build(BuildContext context) {

    DateTime sunrise = DateTime.fromMillisecondsSinceEpoch((_weather?.sunrisetime ?? 1720031400) *1000);
    DateTime sunset = DateTime.fromMillisecondsSinceEpoch((_weather?.sunsettime ?? 1720031400) *1000);



    String fsunrise = DateFormat('hh:mm a').format(sunrise);
    String fsunset = DateFormat('hh:mm a').format(sunset);

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE dd, yyyy').format(now);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 45, 60),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),

//BODY
//BG BLUR
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 1 * kToolbarHeight, 20, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),

              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),

              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 248, 243, 239),
                  ),
                ),
              ),

              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  color: Colors.transparent,
                ),
              ),

//TEXT MEDIA
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Text(
                      '📍${_weather?.cityName ?? "loading city.."}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w300,
                      ),
                    ),

                    const Center(
                      child: Text(
                        'Hello There!',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Image.asset(
                      weathericon(_weather?.weatherid),
                      scale: 2,
                    ),

                     Center(
                      child: Text(
                        '${_weather?.temperature.round() ?? '--'}°C',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 55,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                     Center(
                      child: Text(
                        _weather?.mainCondition ?? "--",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                     Center(
                      child: Text(
                        formattedDate,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
//ROW 1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
//SUNRISE/SUNSET ROW
                        Row(
                          children: [
                            Image.asset(
                              'assets/11.png',
                              scale: 8,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Sunrise',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  '$fsunrise IST',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),

                        Row(
                          children: [
                            Image.asset(
                              'assets/12.png',
                              scale: 8,
                            ),

                            const SizedBox(
                              width: 10,
                            ),

//SUNSET
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Sunset',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  '$fsunset IST',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Divider(
                        color: Color.fromARGB(255, 70, 70, 70),
                      ),
                    ),

//TEMP MIN/MAX
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
//Tempmax
                        Row(
                          children: [
                            Image.asset(
                              'assets/13.png',
                              scale: 8,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Temp Max',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  '${_weather?.maxtemperature.round() ?? '--'}°C',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),

                        const SizedBox(
                          width: 5,
                        ),

//TempMin
                        Row(
                          children: [
                            Image.asset(
                              'assets/14.png',
                              scale: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               const Text(
                                  'Temp Min',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  '${_weather?.mintemperature.round() ?? '--'}°C',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

