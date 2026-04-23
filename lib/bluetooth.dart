import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class BluetoothService {
  static const MethodChannel methodChannel = MethodChannel('bluetooth_classic');
  static const EventChannel eventChannel = EventChannel('bluetooth_stream');

  static StreamSubscription? _subscription;

  // =======================
  // ✅ Get devices
  // =======================
  static Future<List> getDevices() async {
    return await methodChannel.invokeMethod("getPairedDevices");
  }

  // =======================
  // ✅ Connect
  // =======================
  static Future<void> connect(String address) async {
    await methodChannel.invokeMethod("connect", {
      "address": address,
    });
  }

  // =======================
  // 🔴 Disconnect
  // =======================
  static Future<void> disconnect() async {
    try {
      _subscription?.cancel();
      _subscription = null;

      await methodChannel.invokeMethod("disconnect");
    } catch (e) {
      print("DISCONNECT ERROR: $e");
    }
  }

  // =======================
  // 📡 Start Listening
  // =======================
  static void startListening() {
    // منع تكرار الاستماع
    if (_subscription != null) return;

    _subscription = eventChannel.receiveBroadcastStream().listen(
          (data) {
        print("DATA: $data");

        final parsed = parseData(data);

        sendToServer(parsed);
      },
      onError: (e) {
        print("ERROR: $e");
      },
    );
  }

  // =======================
  // 🔍 Parse Data
  // =======================
  static String parseData(dynamic raw) {
    return raw.toString().trim();
  }

  // =======================
  // 🌐 API
  // =======================
  static DateTime? _lastSent;

  static Future<void> sendToServer(String data) async {
    // 🔥 منع spam على السيرفر (مرة كل ثانية)
    if (_lastSent != null &&
        DateTime.now().difference(_lastSent!).inMilliseconds < 1000) {
      return;
    }

    _lastSent = DateTime.now();

    final url = Uri.parse("https://your-api.com/data"); // 👈 حط الـ endpoint هنا

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          // "Authorization": "Bearer TOKEN", // لو عندك توكن
        },
        body: jsonEncode({
          "device_data": data,
        }),
      );

      print("STATUS: ${response.statusCode}");
    } catch (e) {
      print("API ERROR: $e");
    }
  }
}