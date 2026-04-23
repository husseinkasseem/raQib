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

class MainActivity: FlutterActivity() {

    private val METHOD_CHANNEL = "bluetooth_classic"
    private val EVENT_CHANNEL = "bluetooth_stream"

    private var socket: BluetoothSocket? = null
    private var inputStream: InputStream? = null
    private var listeningThread: Thread? = null

    private val DEFAULT_UUID: UUID =
        UUID.fromString("00001101-0000-1000-8000-00805F9B34FB")

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // =======================
        // 🔵 MethodChannel
        // =======================
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL)
            .setMethodCallHandler { call, result ->

                when (call.method) {

                    "getPairedDevices" -> {
                        val adapter = BluetoothAdapter.getDefaultAdapter()

                        if (adapter == null) {
                            result.error("NO_BLUETOOTH", "Bluetooth not supported", null)
                            return@setMethodCallHandler
                        }

                        val devices = adapter.bondedDevices
                        val list = mutableListOf<Map<String, String>>()

                        for (device in devices) {
                            list.add(
                                mapOf(
                                    "name" to (device.name ?: "Unknown"),
                                    "address" to device.address
                                )
                            )
                        }

                        result.success(list)
                    }

                    "connect" -> {
                        val address = call.argument<String>("address")

                        if (address == null) {
                            result.error("INVALID_ADDRESS", "Address is null", null)
                            return@setMethodCallHandler
                        }

                        try {
                            val adapter = BluetoothAdapter.getDefaultAdapter()
                            val device: BluetoothDevice = adapter.getRemoteDevice(address)

                            socket = device.createRfcommSocketToServiceRecord(DEFAULT_UUID)

                            adapter.cancelDiscovery()

                            socket?.connect()
                            inputStream = socket?.inputStream

                            result.success("connected")

                        } catch (e: Exception) {
                            closeConnection()
                            result.error("CONNECTION_FAILED", e.message, null)
                        }
                    }

                    "disconnect" -> {
                        closeConnection()
                        result.success("disconnected")
                    }

                    else -> result.notImplemented()
                }
            }

        // =======================
        // 🟢 EventChannel
        // =======================
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {

                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {

                    val stream = inputStream

                    if (stream == null) {
                        events?.error("NO_STREAM", "Not connected", null)
                        return
                    }

                    listeningThread = Thread {
                        val buffer = ByteArray(1024)

                        try {
                            while (!Thread.currentThread().isInterrupted) {

                                val bytes = stream.read(buffer)

                                // 🔥 لو الاتصال اتقفل
                                if (bytes == -1) break

                                if (bytes > 0) {
                                    val data = String(buffer, 0, bytes)

                                    // 🔥 لازم Main Thread
                                    runOnUiThread {
                                        events?.success(data)
                                    }
                                }
                            }

                        } catch (e: Exception) {
                            runOnUiThread {
                                events?.error("READ_ERROR", e.message, null)
                            }
                        }
                    }

                    listeningThread?.start()
                }

                override fun onCancel(arguments: Any?) {
                    listeningThread?.interrupt()
                    listeningThread = null
                }
            })
    }

    // =======================
    // 🔴 Clean Close
    // =======================
    private fun closeConnection() {
        try {
            listeningThread?.interrupt()
            listeningThread = null

            inputStream?.close()
            inputStream = null

            socket?.close()
            socket = null

        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}