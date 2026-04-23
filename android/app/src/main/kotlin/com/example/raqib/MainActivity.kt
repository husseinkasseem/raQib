package com.example.raqib

import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothSocket
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import java.io.InputStream
import java.util.UUID

class MainActivity : FlutterActivity() {

    private val METHOD_CHANNEL = "bluetooth_classic"
    private val EVENT_CHANNEL = "obd_stream"

    private var socket: BluetoothSocket? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val adapter = BluetoothAdapter.getDefaultAdapter()

        // ✅ MethodChannel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL)
            .setMethodCallHandler { call, result ->

                when (call.method) {

                    // 🔍 الأجهزة المقترنة
                    "getPairedDevices" -> {

                        if (adapter == null) {
                            result.error("NO_BT", "Bluetooth not supported", null)
                            return@setMethodCallHandler
                        }

                        if (!adapter.isEnabled) {
                            result.error("OFF", "Bluetooth is OFF", null)
                            return@setMethodCallHandler
                        }

                        val devices: Set<BluetoothDevice> = adapter.bondedDevices

                        val list = devices.map {
                            mapOf(
                                "name" to (it.name ?: "Unknown"),
                                "address" to it.address
                            )
                        }

                        result.success(list)
                    }

                    // 🔗 connect
                    "connect" -> {
                        val address = call.argument<String>("address")

                        try {
                            val device = adapter.getRemoteDevice(address)

                            val uuid = UUID.fromString(
                                "00001101-0000-1000-8000-00805F9B34FB"
                            )

                            socket = device.createRfcommSocketToServiceRecord(uuid)
                            adapter.cancelDiscovery()
                            socket?.connect()

                            result.success(true)

                        } catch (e: Exception) {
                            result.error("CONNECT_ERROR", e.message, null)
                        }
                    }

                    else -> result.notImplemented()
                }
            }

        // ✅ EventChannel (قراءة الداتا)
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {

                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {

                    val inputStream: InputStream? = socket?.inputStream

                    if (inputStream == null) {
                        events?.error("NO_CONNECTION", "Bluetooth not connected", null)
                        return
                    }

                    val thread = Thread {
                        try {
                            val buffer = ByteArray(1024)

                            while (!Thread.currentThread().isInterrupted) {
                                val bytes = inputStream.read(buffer)
                                val data = String(buffer, 0, bytes)

                                events?.success(data)
                            }
                        } catch (e: Exception) {
                            events?.error("READ_ERROR", e.message, null)
                        }
                    }

                    thread.start()
                }

                override fun onCancel(arguments: Any?) {}
            })
    }
}