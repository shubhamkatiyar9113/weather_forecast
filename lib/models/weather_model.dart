class WeatherModel {
  final String city;
  final double temp;
  final int humidity;
  final String condition;
  final String icon;
  final double wind;

  WeatherModel({
    required this.city,
    required this.temp,
    required this.humidity,
    required this.condition,
    required this.icon,
    required this.wind,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'],
      temp: (json['main']['temp'] as num).toDouble(),
      humidity: json['main']['humidity'],
      condition: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      wind: json['wind']['speed'].toDouble(),
    );
  }
}