import 'package:get/get.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../services/weather_services.dart';
import '../models/daily_forecast_model.dart';

class WeatherController extends GetxController {
  @override
  void onInit() {
    fetchWeather("Delhi");
    fetchForecast("Delhi");
    super.onInit();
  }
  final WeatherService service = WeatherService();

  var weather = Rxn<WeatherModel>();

  var forecastList = <ForecastModel>[].obs;

  /// 📅 5-day grouped forecast
  var dailyForecast = <DailyForecastModel>[].obs;

  var isWeatherLoading = false.obs;
  var isForecastLoading = false.obs;

  /// 🌤 CURRENT WEATHER
  Future<void> fetchWeather(String city) async {
    try {
      isWeatherLoading.value = true;
      isForecastLoading.value = true;

      final result = await service.getWeather(city);
      weather.value = result;

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isWeatherLoading.value = false;
      isForecastLoading.value = false;
    }
  }

  /// 📊 FORECAST (3-hour data + grouped daily)
  Future<void> fetchForecast(String city) async {
    try {
      isWeatherLoading.value = true;
      isForecastLoading.value = false;

      final data = await service.getForecast(city);

      final List list = data["list"] ?? [];

      /// hourly forecast
      forecastList.value = list.map((e) {
        return ForecastModel.fromJson(e);
      }).toList();

      /// daily grouped forecast
      processDailyForecast(data);

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isWeatherLoading.value = false;
      isForecastLoading.value = false;
    }
  }

  /// 📅 GROUP FORECAST BY DATE (FIXED + SAFE)
  void processDailyForecast(Map<String, dynamic> data) {
    final List list = data['list'] ?? [];

    final Map<String, List<Map<String, dynamic>>> grouped = {};

    for (var item in list) {
      final String date = item['dt_txt'].toString().split(" ")[0];

      grouped.putIfAbsent(date, () => []);
      grouped[date]!.add(item);
    }

    dailyForecast.clear();

    grouped.forEach((date, items) {
      double tempSum = 0;

      final String icon = items[0]['weather'][0]['icon'];

      for (var i in items) {
        tempSum += (i['main']['temp'] as num).toDouble();
      }

      final double avgTemp = tempSum / items.length;

      dailyForecast.add(
        DailyForecastModel(
          date: date,
          avgTemp: avgTemp,
          icon: icon,
        ),
      );
    });

    /// 🔥 important for UI refresh (extra safety)
    dailyForecast.refresh();
  }
}