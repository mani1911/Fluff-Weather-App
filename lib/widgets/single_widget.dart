import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/models/weather_locations.dart';
import 'package:http/http.dart' as http;

class WeatherData {
  double? temp;
  double? wind;
  double? humidity;
  double? clouds;
  String? description;
  String? name;

  WeatherData(
      {this.temp,
      this.wind,
      this.humidity,
      this.clouds,
      this.description,
      this.name});

  WeatherData.fromJson(Map<String, dynamic> json) {
    name = json["name"] != "Park Town" ? json["name"] : "Chennai";
    temp = json["main"]["temp"].toDouble();
    wind = json["wind"]["speed"].toDouble();
    humidity = json["main"]["humidity"].toDouble();
    clouds = json["clouds"]["all"].toDouble();
    description = json["weather"][0]["description"];
  }
}

class SingleWeather extends StatefulWidget {
  final int index;
  SingleWeather(this.index);

  @override
  State<SingleWeather> createState() => _SingleWeatherState();
}

class _SingleWeatherState extends State<SingleWeather> {
  DateTime _now = DateTime.now();
  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  Future<WeatherData>? getWeatherData() async {
    var response = await http.get(Uri.parse(
        ('https://api.openweathermap.org/data/2.5/weather?lat=${locationList[widget.index].lat.toString()}&lon=${locationList[widget.index].long.toString()}&appid=e17778845ea8612393fd8e69dd18ac53')));
    var dec = jsonDecode(response.body);

    WeatherData data = WeatherData.fromJson(dec);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    var _curr = '${_now.hour} : ${_now.minute}';
    return FutureBuilder(
        future: getWeatherData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150,
                            ),
                            Text(snapshot.data.name,
                                style: GoogleFonts.lato(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(_curr,
                                    style: GoogleFonts.lato(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Text("am/pm",
                                      style: GoogleFonts.lato(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                (snapshot.data.temp - 273).toStringAsFixed(2) +
                                    "\u2103",
                                style: GoogleFonts.lato(
                                    fontSize: 85,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white)),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  locationList[widget.index].iconUrl,
                                  width: 30,
                                  height: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(snapshot.data.description,
                                    style: GoogleFonts.lato(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 40),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.white30,
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('Wind',
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                Text(snapshot.data.wind.round().toString(),
                                    style: GoogleFonts.lato(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                Text('m/s',
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                Stack(
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 50,
                                      color: Colors.white38,
                                    ),
                                    Container(
                                      height: 5,
                                      width: (snapshot.data.wind / 113) * 50,
                                      color: Colors.greenAccent,
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text('Clouds',
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                Text(snapshot.data.clouds.toString(),
                                    style: GoogleFonts.lato(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                Text('%',
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                Stack(
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 50,
                                      color: Colors.white38,
                                    ),
                                    Container(
                                      height: 5,
                                      width: snapshot.data.clouds / 2,
                                      color: Colors.lightBlue,
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text('Humidity',
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                Text(snapshot.data.humidity.round().toString(),
                                    style: GoogleFonts.lato(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                Text('%',
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                Stack(
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 50,
                                      color: Colors.white38,
                                    ),
                                    Container(
                                      height: 5,
                                      width: snapshot.data.humidity / 2,
                                      color: Colors.redAccent,
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          }
        });
  }
}
