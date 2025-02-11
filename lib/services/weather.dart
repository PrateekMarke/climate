import 'package:climate/services/location.dart';
import 'package:climate/services/networking.dart';
const apikey = '84f1e35d8d18af625a82d4a7e66a88e4';
const opneWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
class WeatherModel {

 Future<dynamic> getCityWeather(String cityName) async {
   Networking networking =Networking('$opneWeatherMapURL?q=$cityName&appid=$apikey');
  //  Networking networking =Networking('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey');

    var weatherData = await networking.getData();
    return weatherData;
    
  }
  Future<dynamic> getLocationWeather()async{
        Location location = Location();
    await location.getCurrnetLocation();

    Networking networking =Networking('$opneWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey');
   
    var weatherData = await networking.getData();
    return weatherData;
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