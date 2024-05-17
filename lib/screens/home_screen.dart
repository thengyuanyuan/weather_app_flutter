import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_flutter/constants/assets.dart';
import '../bloc/weather_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return thunderstormIcon;
      case >= 300 && < 400:
        return dizzleIcon;
      case >= 500 && < 600:
        return rainIcon;
      case >= 600 && < 700:
        return snowIcon;
      case >= 700 && < 800:
        return atmosphereIcon;
      case == 800:
        return clearIcon;
      case > 800 && <= 804:
        return partlyCloudyIcon;
      default:
        return partlyCloudyIcon;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 3,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: 600,
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(1, -0.5),
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
                  alignment: const AlignmentDirectional(-1, -0.3),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, -1.2),
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 100.0,
                    sigmaY: 100.0,
                    tileMode: TileMode.mirror,
                  ),
                  child: const SizedBox(),
                ),
                BlocBuilder<WeatherBloc, WeatherBlocState>(
                  builder: (context, state) {
                    if (state is WeatherBlocSuccess) {
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '📍${state.weather.areaName}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 5),
                            // TODO: change Good morning
                            const Text(
                              "Good Morning",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Center(
                              child: Image.asset(
                                getWeatherIcon(
                                    state.weather.weatherConditionCode!),
                                scale: 2,
                              ),
                            ),
                            Center(
                              child: Text(
                                '${state.weather.temperature!.celsius!.round()} °C',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                state.weather.weatherMain!.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                DateFormat()
                                    .add_MMMEd()
                                    .addPattern(" • ")
                                    .add_Hm()
                                    .format(state.weather.date!),
                                // 'Friday 16 • 09.41pm',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      sunriseImage,
                                      scale: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sunrise',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        Text(
                                          DateFormat()
                                              .add_Hm()
                                              .format(state.weather.sunrise!),
                                          // '5:34am',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      sunsetImage,
                                      scale: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sunset',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        Text(
                                          DateFormat()
                                              .add_Hm()
                                              .format(state.weather.sunset!),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
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
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      tempMaxImage,
                                      scale: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Temp Max',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        Text(
                                          "${state.weather.tempMax!.celsius!.round()} °C",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      tempMinImage,
                                      scale: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Temp Min',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        Text(
                                          "${state.weather.tempMin!.celsius!.round()} °C",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
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
                      );
                    } else {
                      return const Center(
                        child: Text('error'),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
