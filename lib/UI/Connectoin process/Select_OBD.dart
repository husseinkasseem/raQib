import 'package:flutter/material.dart';
import 'package:raqib/UI/Auth/login_screen.dart';
import 'package:raqib/bluetooth.dart';

class SelectOBD extends StatefulWidget {
  static const String routeName = "SelectOBD";

  const SelectOBD({super.key});

  @override
  State<SelectOBD> createState() => _SelectOBDState();
}

class _SelectOBDState extends State<SelectOBD> {
  List<Map<dynamic, dynamic>> devices = [];
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
      final result = await BluetoothService.getDevices();

      setState(() {
        devices = List<Map<dynamic, dynamic>>.from(result ?? []);
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
      await BluetoothService.connect(device['address']);

      // 🔥 تشغيل استقبال البيانات + إرسالها للـ API
      BluetoothService.startListening();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Connected to ${device['name']}")),
      );

      // ✅ الانتقال بعد الاتصال
      Navigator.pushNamed(context, LoginScreen.routeName);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Connection Failed")),
      );
    } finally {
      setState(() => isConnecting = false);
    }
  }

  @override
  void dispose() {
    // 🔴 مهم جدًا: قفل الاتصال
    BluetoothService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Select OBD",
          style: TextStyle(color: Colors.blue),
        ),
        actions: [
          IconButton(
            onPressed: loadDevices,
            icon: const Icon(Icons.refresh, color: Colors.blue),
          )
        ],
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
                leading: const Icon(Icons.bluetooth,
                    color: Colors.blue),

                title: Text(
                  device['name'] ?? "Unknown",
                  style: const TextStyle(color: Colors.white),
                ),

                subtitle: Text(
                  device['address'] ?? "",
                  style: const TextStyle(color: Colors.grey),
                ),

                onTap: isConnecting
                    ? null
                    : () => connectToDevice(device),
              );
            },
          ),

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