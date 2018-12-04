package me.yohom.amapbase.utils

import android.graphics.BitmapFactory
import com.amap.api.maps.model.BitmapDescriptor
import com.amap.api.maps.model.BitmapDescriptorFactory
import me.yohom.amapbase.AMapBasePlugin

const val PACKAGE = "packages/amap_base/"

object UnifiedAssets {
    private val assetManager = AMapBasePlugin.registrar.context().assets

    fun getBitmapDescriptor(asset: String): BitmapDescriptor {
        val assetFileDescriptor = assetManager.openFd(AMapBasePlugin.registrar.lookupKeyForAsset(asset, PACKAGE))
        return BitmapDescriptorFactory.fromBitmap(BitmapFactory.decodeStream(assetFileDescriptor.createInputStream()))
    }
}