import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apikey = '681d1dd01aedcbf0632d9dc2d1d2d527';


class WeatherModel {
  Future<dynamic> getcitylocation(String cityname) async{
    Networkser networkser = Networkser('https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apikey&units=metric');
    var weatherdata = await networkser.getdata();
    return weatherdata;
  }


  Future<dynamic> locationweatherca() async {
    Location location = Location();
    await location.getcurrentlocation();

    Networkser getnetwork = Networkser('https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric');
    var wedherdata = await getnetwork.getdata();
    return wedherdata;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
