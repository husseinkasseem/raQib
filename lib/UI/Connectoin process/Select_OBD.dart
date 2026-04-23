import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectOBD extends StatefulWidget {
  static const String routeName = "SelectOBD";
  const SelectOBD({super.key});

  @override
  State<SelectOBD> createState() => _SelectOBDState();
}

class _SelectOBDState extends State<SelectOBD> {
  static const platform = MethodChannel('bluetooth_classic');

  List devices = [];
  bool isLoading = false;
  bool isConnecting = false;

  @override
  void initState() {
    super.initState();
    loadDevices();
  }

  // 🔍 تحميل الأجهزة
  Future<void> loadDevices() async {
    setState(() => isLoading = true);

    try {
      final result = await platform.invokeMethod('getPairedDevices');

      setState(() {
        devices = result ?? [];
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() => isLoading = false);
    }
  }

  // 🔗 الاتصال
  Future<void> connectToDevice(Map device) async {
    setState(() => isConnecting = true);

    try {
      await platform.invokeMethod('connect', {
        "address": device['address'],
      });

      print("Connected to ${device['name']}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Connected to ${device['name']}")),
      );

      // ✅ التنقل بعد النجاح فقط

    } catch (e) {
      print("Connection error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Connection Failed")),
      );
    } finally {
      setState(() => isConnecting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Select OBD"),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : devices.isEmpty
          ? const Center(
        child: Text(
          "No paired devices",
          style: TextStyle(color: Colors.white),
        ),
      )
          : Stack(
        children: [
          ListView.builder(
            itemCount: devices.length,
            itemBuilder: (context, index) {
              final device = devices[index];

              return ListTile(
                title: Text(
                  device['name'] ?? "Unknown",
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  device['address'],
                  style: const TextStyle(color: Colors.grey),
                ),
                onTap: isConnecting
                    ? null
                    : () => connectToDevice(device),
              );
            },
          ),

          // 🔄 لودر أثناء الاتصال
          if (isConnecting)
            Container(
              color: Colors.black.withOpacity(0.6),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}