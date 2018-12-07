package me.yohom.amapbase.common

import android.Manifest
import android.support.v4.app.ActivityCompat
import me.yohom.amapbase.AMapBasePlugin

fun Any.checkPermission() {
    ActivityCompat.requestPermissions(
            AMapBasePlugin.registrar.activity(),
            arrayOf(Manifest.permission.ACCESS_COARSE_LOCATION,
                    Manifest.permission.ACCESS_FINE_LOCATION,
                    Manifest.permission.WRITE_EXTERNAL_STORAGE,
                    Manifest.permission.READ_EXTERNAL_STORAGE,
                    Manifest.permission.READ_PHONE_STATE),
            321
    )
}