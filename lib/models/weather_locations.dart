import 'package:flutter/material.dart';

class WeatherLocation {
  final String city;
  final String dateTime;
  final String temparature;
  final String weatherType;
  final String iconUrl;
  final int wind;
  final int rain;
  final int humidity;
  final double lat;
  final double long;

  WeatherLocation({
    required this.city,
    required this.dateTime,
    required this.temparature,
    required this.weatherType,
    required this.iconUrl,
    required this.wind,
    required this.rain,
    required this.humidity,
    required this.lat,
    required this.long,
  });
}

final locationList = [
  WeatherLocation(
    city: 'Kolkata',
    lat: 22.5726,
    long: 88.3639,
    dateTime: '07:50 PM — Monday, 9 Nov 2020',
    temparature: '24\u2103',
    weatherType: 'Night',
    iconUrl: 'assets/moon.svg',
    wind: 10,
    rain: 2,
    humidity: 10,
  ),
  WeatherLocation(
    city: 'Chennai',
    lat: 13.0827,
    long: 80.2707,
    dateTime: '02:20 PM — Monday, 9 Nov 2020',
    temparature: '15\u2103',
    weatherType: 'Cloudy',
    iconUrl: 'assets/cloudy.svg',
    wind: 8,
    rain: 7,
    humidity: 82,
  ),
  WeatherLocation(
    city: 'Banglore',
    lat: 12.9716,
    long: 77.5946,
    dateTime: '09:20 AM — Monday, 9 Nov 2020',
    temparature: '17\u2103',
    weatherType: 'Sunny',
    iconUrl: 'assets/sun.svg',
    wind: 5,
    rain: 15,
    humidity: 61,
  ),
  WeatherLocation(
    city: 'Hyderabad',
    lat: 17.3850,
    long: 78.4867,
    dateTime: '01:20 AM — Tuesday, 10 Nov 2020',
    temparature: '10\u2103',
    weatherType: 'Rainy',
    iconUrl: 'assets/rain.svg',
    wind: 20,
    rain: 70,
    humidity: 91,
  ),
];
