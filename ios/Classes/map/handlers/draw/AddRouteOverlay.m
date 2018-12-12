//
// Created by Yohom Bao on 2018-12-12.
//

#import "AddRouteOverlay.h"
#import "AMapViewFactory.h"
#import "UnifiedRouteOverlay.h"
#import "MJExtension.h"
#import "UnifiedAMapOptions.h"
#import "MANaviAnnotation.h"
#import "MANaviRoute.h"
#import "Misc.h"


@implementation AddRouteOverlay {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *overlayJson = (NSString *) paramDic[@"overlay"];

    NSLog(@"方法map#addRouteOverlay ios端参数: overlayJson -> %@", overlayJson);
    UnifiedRouteOverlay *routeOverlay = [UnifiedRouteOverlay initWithJson:overlayJson];

    // 添加起终点
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.coordinate = [routeOverlay.from toCLLocationCoordinate2D];
    startAnnotation.title = @"起点";

    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.coordinate = [routeOverlay.to toCLLocationCoordinate2D];
    destinationAnnotation.title = @"终点";

    [_mapView addAnnotation:startAnnotation];
    [_mapView addAnnotation:destinationAnnotation];

    // 添加中间的路径
    UnifiedDrivePath *path = routeOverlay.drivePath;
    MANaviRoute *overlay = [MANaviRoute naviRouteForPath:path
                                            withNaviType:MANaviAnnotationTypeDrive
                                             showTraffic:YES
                                              startPoint:[routeOverlay.from toAMapGeoPoint]
                                                endPoint:[routeOverlay.to toAMapGeoPoint]];
    [overlay addToMapView:_mapView];

    // 收缩地图到路径范围
    [_mapView setVisibleMapRect:[Misc mapRectForOverlays:overlay.routePolylines]
                    edgePadding:UIEdgeInsetsMake(20, 20, 20, 20)
                       animated:YES];
}

@end