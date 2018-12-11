# 高德地图Flutter插件 基于AndroidView和UiKitView

[![pub package](https://img.shields.io/pub/v/amap_base.svg)](https://pub.Flutter-io.cn/packages/amap_base)

[TOC]

## 安装
在你的`pubspec.yaml`文件的dependencies节点下添加:
```
amap_base: x.x.x
```
如果你想要指定某个版本/分支/提交, 那么:
```
amap_base:
  git:
    url: https://github.com/yohom/amap_base_Flutter.git
    ref: 0.0.1/branch/commit
```
导入:
```
import 'package:amap_base/amap_base.dart';
```
Android端设置key:
```
<application>
    ...
    <meta-data
        android:name="com.amap.api.v2.apikey"
        android:value="您的Key"/>
</application>
```
iOS端设置key:
```
await AMap.init('您的key'); // 这个方法在Android端无效
```
iOS端的`UiKitView`目前还只是preview状态, 默认是不支持的, 需要手动打开开关, 在info.plist文件中新增一行`io.Flutter.embedded_views_preview`为`true`. 参考[iOS view embedding support has landed on master](https://github.com/Flutter/Flutter/issues/19030#issuecomment-437534853)

## 关于高德的Android SDK和iOS SDK
- 由于Android和iOS端的实现完全不一样, Android端照抄了Google Map的api设计, 而iOS
端又没有去抄Google Map的设计, 导致需要额外的工作去兼容两个平台的功能. 这个库的目标是尽可能的统一双端的api设置, 采用取各自平台api的**并集**, 然后在文档中指出针对哪个平台有效的策略来实现api统一.

## 关于包的大小
- ~~目前主分支的计划是实现全功能的高德地图, 然后开单独的分支实现高德的单独的功能, 这样包会小一点.~~
- 这个库依赖了高德导航库(包含了3dMap库), 以及搜索库.

## 关于Swift项目
- 这个库做了对Swift项目的相关处理, 但是Flutter项目添加了amap_base依赖之后, 会报高德相关的头文件找不到, 一个解决方案是[为iOS项目手动添加Search Paths](https://blog.csdn.net/yutianlong9306/article/details/53306850). 如果有更好的解决方案, 请告知我.

## 关于项目结构
项目结构按照高德官方网站的[开发指南](https://lbs.amap.com/api/android-sdk/guide/create-project/get-key)组织. 分为`地图`, `定位`, `导航`三大块.

    |-- me.yohom.amapbase
        |-- `AMapBasePlugin`: Flutter插件类
        |-- common: 通用代码
        |-- map: 地图功能模块
            |-- handlers: 单个功能的**处理委托对象**
                |-- calculatetool: `地图计算工具`
                |-- createmap: `创建地图`
                |-- draw: `在地图上绘制`
                |-- fetchdata: `获取地图数据`
                |-- interact: `与地图交互`
                |-- routeplan: `出行路线规划`
            |-- model: 地图数据的模型
            |-- overlay: 覆盖物
            |-- `AMapFactory`: AMapView工厂, Flutter的platform view需要
            |-- `MapFunctionRegistry`: 地图功能登记处, 所有功能都需要在此处注册.
            |-- `MapMethodHandler`: **处理委托对象**接口.
        |-- navi: 导航功能模块(未实现)
        |-- location: 定位功能模块(未实现)

## 关于贡献代码
1. 在`handlers`包下找到要实现的功能模块包, 比如说要实现[显示地图](https://lbs.amap.com/api/android-sdk/guide/create-map/show-map), 那么先找到`me.yohom.amapbase/map/handlers/createmap`包, 然后在该包下创建新的实现`MapMethodHandler`接口的委托类.
2. 实现功能后, 在`MapFunctionRegistry`类中注册功能.
3. 在dart增加对应的方法.
4. 新功能的开发就完成了.

## FAQ:
1. 为什么定位到非洲去了?
- 实际上是定位在了经纬度(0, 0)的位置了, 那个位置大致在非洲西部的几内亚湾, 原因是key
设置错了, 建议检查一下key的设置.
2. 为什么Android端用Flutter运行后奔溃, 但是直接用Android SDK运行成功?
- 指定项目的编译选项`Additional arguments`增加`--target-platform android-arm`.从![screen shot 2018-12-06 at 09 36 20](https://user-images.githubusercontent.com/10418364/49555454-e9c19f00-f93a-11e8-928b-6c3780b81f20.png)这里打开选项对话框.

## TODO LIST:
* [ ] 创建地图
    * [x] 显示地图
    * [x] 显示定位蓝点
    * [x] 显示室内地图
    * [x] 切换地图图层
    * [x] 使用离线地图
    * [x] 显示英文地图
    * [ ] 自定义地图
* [ ] 与地图交互
    * [x] 控件交互
    * [x] 手势交互
    * [x] 调用方法交互
    * [ ] 地图截屏功能
* [ ] 在地图上绘制
    * [x] 绘制点标记
    * [x] 绘制折线
    * [ ] 绘制面
    * [ ] 轨迹纠偏
    * [ ] 点平滑移动
    * [ ] 绘制海量点图层
* [ ] 获取地图数据
    * [x] 获取POI数据
    * [ ] 获取地址描述数据
    * [ ] 获取行政区划数据
    * [ ] 获取公交数据
    * [ ] 获取天气数据
    * [ ] 获取业务数据（云图功能）
    * [ ] 获取交通态势信息
* [ ] 出行线路规划
    * [x] 驾车出行路线规划
    * [ ] 步行出行路线规划
    * [ ] 公交出行路线规划
    * [ ] 骑行出行路线规划
    * [ ] 货车出行路线规划
* [ ] 地图计算工具
    * [x] 坐标转换
    * [ ] 距离/面积计算
    * [ ] 距离测量