package me.yohom.amapbase.map.overlay

import android.content.Context
import com.amap.api.maps.AMap
import com.amap.api.maps.model.LatLng
import com.amap.api.maps.model.MarkerOptions
import com.amap.api.maps.model.PolylineOptions
import com.amap.api.services.core.LatLonPoint
import com.amap.api.services.route.*
import java.util.*

/**
 * 公交路线图层类。在高德地图API里，如果需要显示公交路线，可以用此类来创建公交路线图层。如不满足需求，也可以自己创建自定义的公交路线图层。
 * @since V2.1.0
 */
class BusRouteOverlay
/**
 * 通过此构造函数创建公交路线图层。
 * @_routePlanParam context 当前activity。
 * @_routePlanParam amap 地图对象。
 * @_routePlanParam path 公交路径规划的一个路段。详见搜索服务模块的路径查询包（com.amap.api.services.route）中的类** [BusPath](../../../../../../Search/com/amap/api/services/route/BusPath.html)**。
 * @_routePlanParam start 起点坐标。详见搜索服务模块的核心基础包（com.amap.api.services.core）中的类 **[LatLonPoint](../../../../../../Search/com/amap/api/services/core/LatLonPoint.html)**。
 * @_routePlanParam end 终点坐标。详见搜索服务模块的核心基础包（com.amap.api.services.core）中的类 **[LatLonPoint](../../../../../../Search/com/amap/api/services/core/LatLonPoint.html)**。
 * @since V2.1.0
 */
(context: Context, amap: AMap, private val busPath: BusPath,
 start: LatLonPoint, end: LatLonPoint) : RouteOverlay(context) {
    private var latLng: LatLng? = null

    init {
        startPoint = AMapUtil.convertToLatLng(start)
        endPoint = AMapUtil.convertToLatLng(end)
        mAMap = amap
    }

    /**
     * 添加公交路线到地图上。
     * @since V2.1.0
     */

    fun addToMap() {
        /**
         * 绘制节点和线<br></br>
         * 细节情况较多<br></br>
         * 两个step之间，用step和step1区分<br></br>
         * 1.一个step内可能有步行和公交，然后有可能他们之间连接有断开<br></br>
         * 2.step的公交和step1的步行，有可能连接有断开<br></br>
         * 3.step和step1之间是公交换乘，且没有步行，需要把step的终点和step1的起点连起来<br></br>
         * 4.公交最后一站和终点间有步行，加入步行线路，还会有一些步行marker<br></br>
         * 5.公交最后一站和终点间无步行，之间连起来<br></br>
         */
        try {
            val busSteps = busPath.steps
            for (i in busSteps.indices) {
                val busStep = busSteps[i]
                if (i < busSteps.size - 1) {
                    val busStep1 = busSteps[i + 1]// 取得当前下一个BusStep对象
                    // 假如步行和公交之间连接有断开，就把步行最后一个经纬度点和公交第一个经纬度点连接起来，避免断线问题
                    if (busStep.walk != null && busStep.busLine != null) {
                        checkWalkToBusline(busStep)
                    }

                    // 假如公交和步行之间连接有断开，就把上一公交经纬度点和下一步行第一个经纬度点连接起来，避免断线问题
                    if (busStep.busLine != null
                            && busStep1.walk != null
                            && busStep1.walk.steps.size > 0) {
                        checkBusLineToNextWalk(busStep, busStep1)
                    }
                    // 假如两个公交换乘中间没有步行，就把上一公交经纬度点和下一步公交第一个经纬度点连接起来，避免断线问题
                    if (busStep.busLine != null
                            && busStep1.walk == null
                            && busStep1.busLine != null) {
                        checkBusEndToNextBusStart(busStep, busStep1)
                    }
                    // 和上面的很类似
                    if (busStep.busLine != null
                            && busStep1.walk == null
                            && busStep1.busLine != null) {
                        checkBusToNextBusNoWalk(busStep, busStep1)
                    }
                    if (busStep.busLine != null && busStep1.railway != null) {
                        checkBusLineToNextRailway(busStep, busStep1)
                    }
                    if (busStep1.walk != null &&
                            busStep1.walk.steps.size > 0 &&
                            busStep.railway != null) {
                        checkRailwayToNextWalk(busStep, busStep1)
                    }

                    if (busStep1.railway != null && busStep.railway != null) {
                        checkRailwayToNextRailway(busStep, busStep1)
                    }

                    if (busStep.railway != null && busStep1.taxi != null) {
                        checkRailwayToNextTaxi(busStep, busStep1)
                    }


                }

                if (busStep.walk != null && busStep.walk.steps.size > 0) {
                    addWalkSteps(busStep)
                } else {
                    if (busStep.busLine == null && busStep.railway == null && busStep.taxi == null) {
                        addWalkPolyline(latLng, endPoint)
                    }
                }
                if (busStep.busLine != null) {
                    val routeBusLineItem = busStep.busLine
                    addBusLineSteps(routeBusLineItem)
                    addBusStationMarkers(routeBusLineItem)
                    if (i == busSteps.size - 1) {
                        addWalkPolyline(AMapUtil.convertToLatLng(getLastBuslinePoint(busStep)), endPoint)
                    }
                }
                if (busStep.railway != null) {
                    addRailwayStep(busStep.railway)
                    addRailwayMarkers(busStep.railway)
                    if (i == busSteps.size - 1) {
                        addWalkPolyline(AMapUtil.convertToLatLng(busStep.railway.arrivalstop.location), endPoint)
                    }
                }
                if (busStep.taxi != null) {
                    addTaxiStep(busStep.taxi)
                    addTaxiMarkers(busStep.taxi)
                }
            }
            addStartAndEndMarker()

        } catch (e: Throwable) {
            e.printStackTrace()
        }

    }


    private fun checkRailwayToNextTaxi(busStep: BusStep, busStep1: BusStep) {
        val railwayLastPoint = busStep.railway.arrivalstop.location
        val taxiFirstPoint = busStep1.taxi.origin
        if (railwayLastPoint != taxiFirstPoint) {
            addWalkPolyLineByLatLonPoints(railwayLastPoint, taxiFirstPoint)
        }
    }

    private fun checkRailwayToNextRailway(busStep: BusStep, busStep1: BusStep) {
        val railwayLastPoint = busStep.railway.arrivalstop.location
        val railwayFirstPoint = busStep1.railway.departurestop.location
        if (railwayLastPoint != railwayFirstPoint) {
            addWalkPolyLineByLatLonPoints(railwayLastPoint, railwayFirstPoint)
        }

    }

    private fun checkBusLineToNextRailway(busStep: BusStep, busStep1: BusStep) {
        val busLastPoint = getLastBuslinePoint(busStep)
        val railwayFirstPoint = busStep1.railway.departurestop.location
        if (busLastPoint != railwayFirstPoint) {
            addWalkPolyLineByLatLonPoints(busLastPoint, railwayFirstPoint)
        }

    }

    private fun checkRailwayToNextWalk(busStep: BusStep, busStep1: BusStep) {
        val railwayLastPoint = busStep.railway.arrivalstop.location
        val walkFirstPoint = getFirstWalkPoint(busStep1)
        if (railwayLastPoint != walkFirstPoint) {
            addWalkPolyLineByLatLonPoints(railwayLastPoint, walkFirstPoint)
        }

    }

    private fun addRailwayStep(railway: RouteRailwayItem) {
        val railwaylistpoint = ArrayList<LatLng>()
        val railwayStationItems = ArrayList<RailwayStationItem>()
        railwayStationItems.add(railway.departurestop)
        railwayStationItems.addAll(railway.viastops)
        railwayStationItems.add(railway.arrivalstop)
        for (i in railwayStationItems.indices) {
            railwaylistpoint.add(AMapUtil.convertToLatLng(railwayStationItems[i].location))
        }
        addRailwayPolyline(railwaylistpoint)
    }

    private fun addTaxiStep(taxi: TaxiItem) {
        addPolyLine(PolylineOptions().width(routeWidth)
                .color(busColor)
                .add(AMapUtil.convertToLatLng(taxi.origin))
                .add(AMapUtil.convertToLatLng(taxi.destination)))
    }

    /**
     * @_routePlanParam busStep
     */
    private fun addWalkSteps(busStep: BusStep) {
        val routeBusWalkItem = busStep.walk
        val walkSteps = routeBusWalkItem.steps
        for (j in walkSteps.indices) {
            val walkStep = walkSteps[j]
            if (j == 0) {
                val latLng = AMapUtil.convertToLatLng(walkStep
                        .polyline[0])
                val road = walkStep.road// 道路名字
                val instruction = getWalkSnippet(walkSteps)// 步行导航信息
                addWalkStationMarkers(latLng, road, instruction)
            }

            val listWalkPolyline = AMapUtil
                    .convertArrList(walkStep.polyline)
            this.latLng = listWalkPolyline.get(listWalkPolyline.size - 1)

            addWalkPolyline(listWalkPolyline)

            // 假如步行前一段的终点和下的起点有断开，断画直线连接起来，避免断线问题
            if (j < walkSteps.size - 1) {
                val lastLatLng = listWalkPolyline.get(listWalkPolyline
                        .size - 1)
                val firstlatLatLng = AMapUtil
                        .convertToLatLng(walkSteps[j + 1].polyline[0])
                if (!lastLatLng.equals(firstlatLatLng)) {
                    addWalkPolyline(lastLatLng, firstlatLatLng)
                }
            }

        }
    }

    /**
     * 添加一系列的bus PolyLine
     *
     * @_routePlanParam routeBusLineItem
     */
    private fun addBusLineSteps(routeBusLineItem: RouteBusLineItem) {
        addBusLineSteps(routeBusLineItem.polyline)
    }

    private fun addBusLineSteps(listPoints: List<LatLonPoint>) {
        if (listPoints.size < 1) {
            return
        }
        addPolyLine(PolylineOptions().width(routeWidth)
                .color(busColor)
                .addAll(AMapUtil.convertArrList(listPoints)))
    }

    /**
     * @_routePlanParam latLng
     * marker
     * @_routePlanParam title
     * @_routePlanParam snippet
     */
    private fun addWalkStationMarkers(latLng: LatLng, title: String,
                                      snippet: String) {
        addStationMarker(MarkerOptions().position(latLng).title(title)
                .snippet(snippet).anchor(0.5f, 0.5f).visible(nodeIconVisible)
                .icon(walkBitmapDescriptor))
    }

    /**
     * @_routePlanParam routeBusLineItem
     */
    private fun addBusStationMarkers(routeBusLineItem: RouteBusLineItem) {
        val startBusStation = routeBusLineItem
                .departureBusStation
        val position = AMapUtil.convertToLatLng(startBusStation
                .latLonPoint)
        val title = routeBusLineItem.busLineName
        val snippet = getBusSnippet(routeBusLineItem)

        addStationMarker(MarkerOptions().position(position).title(title)
                .snippet(snippet).anchor(0.5f, 0.5f).visible(nodeIconVisible)
                .icon(busBitmapDescriptor))
    }

    private fun addTaxiMarkers(taxiItem: TaxiItem) {

        val position = AMapUtil.convertToLatLng(taxiItem
                .origin)
        val title = taxiItem.getmSname() + "打车"
        val snippet = "到终点"

        addStationMarker(MarkerOptions().position(position).title(title)
                .snippet(snippet).anchor(0.5f, 0.5f).visible(nodeIconVisible)
                .icon(driveBitmapDescriptor))
    }

    private fun addRailwayMarkers(railway: RouteRailwayItem) {
        val Departureposition = AMapUtil.convertToLatLng(railway
                .departurestop.location)
        val Departuretitle = railway.departurestop.name + "上车"
        val Departuresnippet = railway.name

        addStationMarker(MarkerOptions().position(Departureposition).title(Departuretitle)
                .snippet(Departuresnippet).anchor(0.5f, 0.5f).visible(nodeIconVisible)
                .icon(busBitmapDescriptor))


        val Arrivalposition = AMapUtil.convertToLatLng(railway
                .arrivalstop.location)
        val Arrivaltitle = railway.arrivalstop.name + "下车"
        val Arrivalsnippet = railway.name

        addStationMarker(MarkerOptions().position(Arrivalposition).title(Arrivaltitle)
                .snippet(Arrivalsnippet).anchor(0.5f, 0.5f).visible(nodeIconVisible)
                .icon(busBitmapDescriptor))
    }

    /**
     * 如果换乘没有步行 检查bus最后一点和下一个step的bus起点是否一致
     *
     * @_routePlanParam busStep
     * @_routePlanParam busStep1
     */
    private fun checkBusToNextBusNoWalk(busStep: BusStep, busStep1: BusStep) {
        val endbusLatLng = AMapUtil
                .convertToLatLng(getLastBuslinePoint(busStep))
        val startbusLatLng = AMapUtil
                .convertToLatLng(getFirstBuslinePoint(busStep1))
        if (startbusLatLng.latitude - endbusLatLng.latitude > 0.0001 || startbusLatLng.longitude - endbusLatLng.longitude > 0.0001) {
            drawLineArrow(endbusLatLng, startbusLatLng)// 断线用带箭头的直线连?
        }
    }

    /**
     *
     * checkBusToNextBusNoWalk 和这个类似
     *
     * @_routePlanParam busStep
     * @_routePlanParam busStep1
     */
    private fun checkBusEndToNextBusStart(busStep: BusStep, busStep1: BusStep) {
        val busLastPoint = getLastBuslinePoint(busStep)
        val endbusLatLng = AMapUtil.convertToLatLng(busLastPoint)
        val busFirstPoint = getFirstBuslinePoint(busStep1)
        val startbusLatLng = AMapUtil.convertToLatLng(busFirstPoint)
        if (!endbusLatLng.equals(startbusLatLng)) {
            drawLineArrow(endbusLatLng, startbusLatLng)//
        }
    }

    /**
     * 检查bus最后一步和下一各step的步行起点是否一致
     *
     * @_routePlanParam busStep
     * @_routePlanParam busStep1
     */
    private fun checkBusLineToNextWalk(busStep: BusStep, busStep1: BusStep) {
        val busLastPoint = getLastBuslinePoint(busStep)
        val walkFirstPoint = getFirstWalkPoint(busStep1)
        if (busLastPoint != walkFirstPoint) {
            addWalkPolyLineByLatLonPoints(busLastPoint, walkFirstPoint)
        }
    }

    /**
     * 检查 步行最后一点 和 bus的起点 是否一致
     *
     * @_routePlanParam busStep
     */
    private fun checkWalkToBusline(busStep: BusStep) {
        val walkLastPoint = getLastWalkPoint(busStep)
        val buslineFirstPoint = getFirstBuslinePoint(busStep)

        if (walkLastPoint != buslineFirstPoint) {
            addWalkPolyLineByLatLonPoints(walkLastPoint, buslineFirstPoint)
        }
    }

    /**
     * @_routePlanParam busStep1
     * @return
     */
    private fun getFirstWalkPoint(busStep1: BusStep): LatLonPoint {
        return busStep1.walk.steps[0].polyline[0]
    }

    /**
     *
     */
    private fun addWalkPolyLineByLatLonPoints(pointFrom: LatLonPoint,
                                              pointTo: LatLonPoint) {
        val latLngFrom = AMapUtil.convertToLatLng(pointFrom)
        val latLngTo = AMapUtil.convertToLatLng(pointTo)

        addWalkPolyline(latLngFrom, latLngTo)
    }

    /**
     * @_routePlanParam latLngFrom
     * @_routePlanParam latLngTo
     * @return
     */
    private fun addWalkPolyline(latLngFrom: LatLng?, latLngTo: LatLng?) {
        addPolyLine(PolylineOptions().add(latLngFrom, latLngTo)
                .width(routeWidth).color(walkColor).setDottedLine(true))
    }

    /**
     * @_routePlanParam listWalkPolyline
     */
    private fun addWalkPolyline(listWalkPolyline: List<LatLng>) {

        addPolyLine(PolylineOptions().addAll(listWalkPolyline)
                .color(walkColor).width(routeWidth).setDottedLine(true))
    }

    private fun addRailwayPolyline(listPolyline: List<LatLng>) {

        addPolyLine(PolylineOptions().addAll(listPolyline)
                .color(driveColor).width(routeWidth))
    }


    private fun getWalkSnippet(walkSteps: List<WalkStep>): String {
        var disNum = 0f
        for (step in walkSteps) {
            disNum += step.distance
        }
        return "\u6B65\u884C" + disNum + "\u7C73"
    }

    fun drawLineArrow(latLngFrom: LatLng, latLngTo: LatLng) {

        addPolyLine(PolylineOptions().add(latLngFrom, latLngTo).width(3f)
                .color(busColor).width(routeWidth))// 绘制直线
    }

    private fun getBusSnippet(routeBusLineItem: RouteBusLineItem): String {
        return ("("
                + routeBusLineItem.departureBusStation.busStationName
                + "-->"
                + routeBusLineItem.arrivalBusStation.busStationName
                + ") \u7ECF\u8FC7" + (routeBusLineItem.passStationNum + 1)
                + "\u7AD9")
    }

    /**
     * @_routePlanParam busStep
     * @return
     */
    private fun getLastWalkPoint(busStep: BusStep): LatLonPoint {

        val walkSteps = busStep.walk.steps
        val walkStep = walkSteps[walkSteps.size - 1]
        val lonPoints = walkStep.polyline
        return lonPoints[lonPoints.size - 1]
    }

    private fun getExitPoint(busStep: BusStep): LatLonPoint? {
        val doorway = busStep.exit ?: return null
        return doorway.latLonPoint
    }

    private fun getLastBuslinePoint(busStep: BusStep): LatLonPoint {
        val lonPoints = busStep.busLine.polyline

        return lonPoints[lonPoints.size - 1]
    }

    private fun getEntrancePoint(busStep: BusStep): LatLonPoint? {
        val doorway = busStep.entrance ?: return null
        return doorway.latLonPoint
    }

    private fun getFirstBuslinePoint(busStep: BusStep): LatLonPoint {
        return busStep.busLine.polyline[0]
    }
}
