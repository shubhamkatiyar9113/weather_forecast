import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/weather_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final WeatherController controller = Get.put(WeatherController());
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2027),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0F2027),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.find<AuthController>().logout();
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            /// SEARCH BAR
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),

              child: TextField(
                controller: cityController,
                style: const TextStyle(color: Colors.white),

                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search city",
                  hintStyle: const TextStyle(color: Colors.grey),

                  prefixIcon: const Icon(Icons.search, color: Colors.white),

                  suffixIcon: IconButton(
                    onPressed: () {
                      if (cityController.text.trim().isNotEmpty) {
                        controller.fetchWeather(cityController.text.trim());
                        controller.fetchForecast(cityController.text.trim());
                      }
                    },
                    icon: const Icon(Icons.send, color: Colors.limeAccent),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// MAIN UI
            Expanded(
              child: Obx(() {

                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.limeAccent),
                  );
                }

                if (controller.weather.value == null) {
                  return const Center(
                    child: Text(
                      "Search city to get weather",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                final weather = controller.weather.value!;

                return SingleChildScrollView(
                  child: Column(
                    children: [

                      /// WEATHER ICON
                      Image.network(
                        "https://openweathermap.org/img/wn/${weather.icon}@4x.png",
                        height: 140,
                      ),

                      const SizedBox(height: 10),

                      /// CITY
                      Text(
                        weather.city,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      /// TEMP
                      Text(
                        "${weather.temp}°C",
                        style: const TextStyle(
                          color: Colors.limeAccent,
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      /// CONDITION
                      Text(
                        weather.condition,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// INFO BOX
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _infoBox(Icons.water_drop,
                              "${weather.humidity}%", "Humidity", Colors.blue),

                          _infoBox(Icons.air,
                              "${weather.wind} km/h", "Wind", Colors.greenAccent),
                        ],
                      ),

                      const SizedBox(height: 30),

                      /// HOURLY TITLE
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Hourly Forecast",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// HOURLY LIST
                      Obx(() {

                        if (controller.forecastList.isEmpty) {
                          return const Text(
                            "No forecast data",
                            style: TextStyle(color: Colors.grey),
                          );
                        }

                        return SizedBox(
                          height: 130,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.forecastList.length,
                            itemBuilder: (context, index) {

                              final item = controller.forecastList[index];

                              /// SAFE TIME PARSING
                              String time = "--:--";
                              if (item.time.contains(" ")) {
                                final parts = item.time.split(" ");
                                if (parts.length > 1 && parts[1].length >= 5) {
                                  time = parts[1].substring(0, 5);
                                }
                              }

                              return Container(
                                width: 110,
                                margin: const EdgeInsets.only(right: 10),

                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.white10),
                                ),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text(
                                      time,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    Image.network(
                                      "https://openweathermap.org/img/wn/${item.icon}@2x.png",
                                      height: 40,
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      "${item.temp.toStringAsFixed(0)}°",
                                      style: const TextStyle(
                                        color: Colors.limeAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }),

                      const SizedBox(height: 30),

                      /// 5 DAY TITLE
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "5-Day Forecast",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// DAILY LIST
                      Obx(() {

                        if (controller.dailyForecast.isEmpty) {
                          return const Text(
                            "No daily data",
                            style: TextStyle(color: Colors.grey),
                          );
                        }

                        return SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.dailyForecast.length,
                            itemBuilder: (context, index) {

                              final item = controller.dailyForecast[index];

                              return Container(
                                width: 110,
                                margin: const EdgeInsets.only(right: 10),

                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.white10),
                                ),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text(
                                      item.date.length > 5
                                          ? item.date.substring(5)
                                          : item.date,
                                      style: const TextStyle(color: Colors.white),
                                    ),

                                    const SizedBox(height: 10),

                                    Image.network(
                                      "https://openweathermap.org/img/wn/${item.icon}@2x.png",
                                      height: 40,
                                    ),

                                    const SizedBox(height: 10),

                                    Text(
                                      "${item.avgTemp.toStringAsFixed(0)}°",
                                      style: const TextStyle(
                                        color: Colors.limeAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(
      IconData icon,
      String value,
      String label,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}