import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'api_service.dart';

class TelemetryManager {
  static final TelemetryManager _instance = TelemetryManager._internal();
  factory TelemetryManager() => _instance;
  TelemetryManager._internal();

  Socket? _socket;
  Timer? _timer;
  bool isConnected = false;
  bool isTripStarted = false;

  int rpm = 0;
  int speed = 0;
  int temp = 0;
  double fuel = 0.0;
  double lat = 0.0;
  double lng = 0.0;
  double odo = 0.0;
  int heading = 0;

  Future<bool> connect(String ip) async {
    try {
      _socket?.destroy();
      _socket = await Socket.connect(ip, 35000,
          timeout: const Duration(seconds: 5));

      _socket!.listen((data) {
        String response = utf8.decode(data).trim();
        List<String> lines = response.split('\r');

        for (var line in lines) {
          _handleResponse(line.trim());
        }
      }, onDone: () => stopTrip(), onError: (e) => stopTrip());

      isConnected = true;
      return true;
    } catch (e) {
      return false;
    }
  }

  void _handleResponse(String res) {
    if (res.isEmpty || res == ">") return;

    try {
      int parsedRpm = _parseRpm(res);
      if (parsedRpm != 0) rpm = parsedRpm;

      int parsedSpeed = _parseSpeed(res);
      if (parsedSpeed != 0) speed = parsedSpeed;

      if (res.contains("41 05")) {
        temp =
            int.parse(res.split(" ")[2].replaceAll(">", ""), radix: 16) - 40;
      } else if (res.contains("41 2F")) {
        fuel = int.parse(
            res.split(" ")[2].replaceAll(">", ""), radix: 16) /
            2.55;
      } else if (res.contains("GPS")) {
        var p = res.split(" ");
        lat = double.parse(p[1]);
        lng = double.parse(p[2]);
        heading = double.parse(p[3]).toInt();
        odo = double.parse(p[4].replaceAll(">", ""));
      }
    } catch (e) {
      print("⚠️ Parser Error: $res");
    }
  }

  int _parseRpm(String response) {
    List<String> parts = response.split(' ');
    if (parts.length >= 4 && parts[1] == "0C") {
      int a = int.parse(parts[2], radix: 16);
      int b = int.parse(parts[3].replaceAll(">", ""), radix: 16);
      return ((a * 256) + b) ~/ 4;
    }
    return 0;
  }

  int _parseSpeed(String response) {
    List<String> parts = response.split(' ');
    if (parts.length >= 3 && parts[1] == "0D") {
      return int.parse(parts[2].replaceAll(">", ""), radix: 16);
    }
    return 0;
  }

  void startTrip() {
    if (isTripStarted) return;
    isTripStarted = true;

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        _socket?.add(utf8.encode("010C\r010D\r0105\r012F\rCUSTOM_GPS\r"));

        await ApiManager.sendTelemetry(
          rpm: rpm,
          speed: speed,
          fuel: fuel,
          temp: temp,
          odo: odo,
          lat: lat,
          lng: lng,
          heading: heading,
          ignitionOn: true,
        );
      } catch (e) {
        print("❌ Loop Error: $e");
      }
    });
  }

  Future<void> stopTrip() async {
    if (!isTripStarted) return;
    isTripStarted = false;

    await ApiManager.sendTelemetry(
      rpm: 0,
      speed: 0,
      fuel: fuel,
      temp: temp,
      odo: odo,
      lat: lat,
      lng: lng,
      heading: 0,
      ignitionOn: false,
    );

    _timer?.cancel();
    _timer = null;

    _socket?.destroy();
    _socket = null;

    isConnected = false;
    rpm = 0;
    speed = 0;
  }
}