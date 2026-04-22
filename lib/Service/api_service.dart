import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiManager {
  static const String baseUrl =
      "https://beeriest-multiperforate-hien.ngrok-free.dev";

  static Future<void> sendTelemetry({
    required int rpm,
    required int speed,
    required double fuel,
    required int temp,
    required double odo,
    required double lat,
    required double lng,
    required int heading,
    bool? ignitionOn,
  }) async {
    var url = Uri.parse("$baseUrl/api/fleet/telemetry");

    final String timestamp =
    DateFormat('yyyy-MM-dd HH:mm:ss', 'en').format(DateTime.now());

    final Map<String, dynamic> bodyData = {
      "device_uid": "DEV-002",
      "speed_kph": speed,
      "rpm": rpm,
      "fuel_level": fuel.toInt(),
      "engine_temp_c": temp,
      "odometer_km": odo.toInt(),
      "lat": lat,
      "lng": lng,
      "heading": heading,
      "driver_id": 1,
      "dt_device": timestamp,
    };

    if (ignitionOn != null) bodyData["ignition_on"] = ignitionOn;

    try {
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "X-API-KEY": "abc1234535XYZ",
          "ngrok-skip-browser-warning": "true",
        },
        body: jsonEncode(bodyData),
      );

      final resData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (ignitionOn == false &&
            resData["result"] != null &&
            resData["result"]["trip_id"] != null) {
          int tripId = resData["result"]["trip_id"];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt("last_trip_id", tripId);
        }
      }

      print("📡 Sent RPM: $rpm, Speed: $speed | Status: ${response.statusCode}");
    } catch (e) {
      print("❌ API Error: $e");
    }
  }

  static Future<Map<String, dynamic>> login(
      String login, String password) async {
    var url = Uri.parse("$baseUrl/api/app/login");

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "login": login,
          "password": password,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"ok": false};
    }
  }

  static Future<Map<String, dynamic>> getEmployeeTrips(
      int employeeId) async {
    var url = Uri.parse("$baseUrl/api/fleet/employee/trips");

    try {
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true"
        },
        body: jsonEncode({"employee_id": employeeId}),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"ok": false};
    }
  }

  static Future<Map<String, dynamic>> getTripSummary(int tripId) async {
    var url = Uri.parse("$baseUrl/api/fleet/trip/summary");

    try {
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true"
        },
        body: jsonEncode({"trip_id": tripId}),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"ok": false};
    }
  }
}