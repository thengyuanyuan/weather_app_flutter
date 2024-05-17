import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../data/my_data.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBloc() : super(WeatherBlocInitial()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory weatherFactory = WeatherFactory(
          API_KEY,
          language: Language.ENGLISH,
        );

        Weather weather = await weatherFactory.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude,
        );

        debugPrint("weather");
        debugPrint(weather.toString());

        emit(WeatherBlocSuccess(weather: weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
