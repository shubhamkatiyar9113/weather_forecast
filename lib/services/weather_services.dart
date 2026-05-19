import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  final String apiKey = "1b8f899f11cf65f1dcba1f87dc3acaca";

  /// 🌤️ CURRENT WEATHER
  Future<WeatherModel> getWeather(String city) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather"
          "?q=$city&appid=$apiKey&units=metric",
    );

    final response = await http.get(url);

    print("WEATHER URL: $url"); // 🔥 DEBUG

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception(
        "Weather API Error: ${response.statusCode} - ${response.body}",
      );
    }
  }

  /// 📊 5 DAY / 3 HOUR FORECAST
  Future<Map<String, dynamic>> getForecast(String city) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast"
          "?q=$city&appid=$apiKey&units=metric",
    );

    final response = await http.get(url);

    print("FORECAST URL: $url"); // 🔥 DEBUG
    print("FORECAST RESPONSE: ${response.body}"); // 🔥 DEBUG

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // ⚠️ IMPORTANT CHECK
      if (data["list"] == null) {
        throw Exception("No forecast list found in API response");
      }

      return data;
    } else {
      throw Exception(
        "Forecast API Error: ${response.statusCode} - ${response.body}",
      );
    }
  }
}