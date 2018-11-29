package me.yohom.amapbase.map.overlay

/**
 *
 */

import android.graphics.Bitmap
import com.amap.api.maps.model.LatLng
import com.amap.api.services.core.LatLonPoint
import java.util.*

internal object AMapServicesUtil {
    var BUFFER_SIZE = 2048

//    @Throws(IOException::class)
//    fun inputStreamToByte(`in`: InputStream): ByteArray {
//
//        val outStream = ByteArrayOutputStream()
//        var data: ByteArray? = ByteArray(BUFFER_SIZE)
//        var count = -1
//        while ((count = `in`.read(data!!, 0, BUFFER_SIZE)) != -1)
//            outStream.write(data, 0, count)
//
//        data = null
//        return outStream.toByteArray()
//    }

    fun convertToLatLonPoint(latlon: LatLng): LatLonPoint {
        return LatLonPoint(latlon.latitude, latlon.longitude)
    }

    fun convertToLatLng(latLonPoint: LatLonPoint): LatLng {
        return LatLng(latLonPoint.latitude, latLonPoint.longitude)
    }

    fun convertArrList(shapes: List<LatLonPoint>): ArrayList<LatLng> {
        val lineShapes = ArrayList<LatLng>()
        for (point in shapes) {
            val latLngTemp = AMapServicesUtil.convertToLatLng(point)
            lineShapes.add(latLngTemp)
        }
        return lineShapes
    }

    fun zoomBitmap(bitmap: Bitmap?, res: Float): Bitmap? {
        if (bitmap == null) {
            return null
        }
        val width: Int
        val height: Int
        width = (bitmap.width * res).toInt()
        height = (bitmap.height * res).toInt()
        return Bitmap.createScaledBitmap(bitmap, width, height, true)
    }

}
