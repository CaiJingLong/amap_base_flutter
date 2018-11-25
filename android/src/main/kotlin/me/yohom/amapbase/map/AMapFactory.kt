package me.yohom.amapbase.map

import android.content.Context
import android.view.View
import android.webkit.WebView
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class AMapFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, id: Int, params: Any?): PlatformView {
        return object : PlatformView {
            override fun getView(): View = WebView(context).apply { loadUrl("https://bbs.hupu.com/acg") }

            override fun dispose() {}
        }
    }
}
