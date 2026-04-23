class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "obd_stream")
            .setStreamHandler(object : EventChannel.StreamHandler {

                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {

                    // مثال: كل ما تجيلك داتا من البلوتوث
                    // ابعتها ل Flutter

                    val thread = Thread {
                        while (true) {
                            val obdData = readFromOBD() // الفنكشن بتاعتك
                            events?.success(obdData)

                            Thread.sleep(1000) // كل ثانية
                        }
                    }
                    thread.start()
                }

                override fun onCancel(arguments: Any?) {}
            })
    }
}