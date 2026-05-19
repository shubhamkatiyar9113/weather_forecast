class ForecastModel {
  final String time;
  final double temp;
  final String icon;

  ForecastModel({
    required this.time,
    required this.temp,
    required this.icon,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      time: json["dt_txt"],
      temp: json["main"]["temp"].toDouble(),
      icon: json["weather"][0]["icon"],
    );
  }
}