package me.yohom.amapbase.common

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken

val gson: Gson = GsonBuilder().serializeNulls().create()

inline fun <reified K> String.parseJson(): K {
    return gson.fromJson(this, object : TypeToken<K>() {}.type)
}

fun Any.toJson(): String {
    return gson.toJson(this)
}