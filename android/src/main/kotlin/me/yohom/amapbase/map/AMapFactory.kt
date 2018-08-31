package me.yohom.amapbase.map

import android.content.Context
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import java.util.concurrent.atomic.AtomicInteger

class AMapFactory(
        private val activityState: AtomicInteger,
        private val pluginRegistrar: Registrar
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, id: Int, params: Any): PlatformView {
        val builder = AMapBuilder()
        Convert.interpretGoogleMapOptions(params, builder)
        return builder.build(id, context, activityState, pluginRegistrar)
    }
}
