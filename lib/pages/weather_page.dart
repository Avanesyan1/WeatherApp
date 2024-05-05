import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {


  final _weatherService = WeatherService("81b7f5c4ed3b5a7be764d2278fbdcad5");

 
 

  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
    
    }
  }

  String getWeatherAnimation(String? mainCondition){
    if (mainCondition == null)  return 'assets/sunny.json';

    switch(mainCondition.toLowerCase()){
      case  'clouds':
      case  'mist':
      case  'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
            return 'assets/cloud.json';
      case  'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case  'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return  'assets/sunny.json';


      

    }
}

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            
            Text(_weather?.cityName ?? "загрузка города..",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 30),),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Column(children: [ Text('${_weather?.temperature.round() ?? ""}°C',style: TextStyle(color: Colors.white,fontSize: 30)),
                               Text('${_weather?.mainCondition ?? '' }',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold))
],)
           
          ],
        ),
      ),
    );
  }
}