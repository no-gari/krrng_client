package com.krrng.krrng_client

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        if (checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            requestPermissions(arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), 0);
        }
    }
}
