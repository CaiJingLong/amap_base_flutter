package me.yohom.amapbase.utils

import com.google.gson.Gson

val gson = Gson()

inline fun <reified K> String.parseJson(): K {
    return gson.fromJson(this, K::class.java)
}

fun Any.parseJson(): String {
    return gson.toJson(this)
}