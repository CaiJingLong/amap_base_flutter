package me.yohom.amapbase.utils

import com.google.gson.Gson
import com.google.gson.reflect.TypeToken

val gson = Gson()

inline fun <reified K> String.parseJson(): K {
    return gson.fromJson(this, object : TypeToken<K>() {}.type)
}

fun Any.parseJson(): String {
    return gson.toJson(this)
}