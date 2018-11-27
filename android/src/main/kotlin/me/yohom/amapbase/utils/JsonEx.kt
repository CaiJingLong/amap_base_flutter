package me.yohom.amapbase.utils

import com.google.gson.Gson

object Jsons {
    val gson = Gson()

    fun toJson(any: Any) {
        gson.toJson(this)
    }

    inline fun <reified T> fromJson(source: String): T {
        return gson.fromJson(source, T::class.java)
    }
}