package me.yohom.amapbase.utils

import android.util.Log
import me.yohom.amapbase.BuildConfig

fun Any.log(content: String) {
    if (BuildConfig.DEBUG) {
        Log.d(this::class.simpleName, content)
    }
}