// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_bloc.dart';

sealed class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherEvent extends WeatherBlocEvent {
  final Position position;

  const FetchWeatherEvent({
    required this.position,
  });

  @override
  List<Object> get props => [position];
}
