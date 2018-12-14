1. 先分清楚要开发的功能需要用到的高德SDK（比如：搜索POI，那么需要的高德SDK即搜索SDK）；
2. fork对应（比如：feature/search）分支；
3. 在该（比如：feature/search）分支下开发：
    1. 在`handlers`包下找到要实现的功能模块包（比如：要实现[获取POI数据](https://lbs.amap.com/api/android-sdk/guide/map-data/poi), 那么先找到`me.yohom.amapbase/search/handlers/fetchdata`包, 然后在该包下创建新的实现`SearchMethodHandler`接口的委托类.
    2. 实现功能后, 在`FunctionRegistry`类中注册功能.
    3. 在dart增加对应的方法.
    4. 新功能的开发就完成了.
4. 向主Repo的对应功能分支（比如：feature/search）发起PR；
